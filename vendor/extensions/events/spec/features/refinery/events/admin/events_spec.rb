# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Events" do
    describe "Admin" do
      describe "events", type: :feature do
        refinery_login

        describe "events list" do
          before do
            FactoryBot.create(:event, :title => "UniqueTitleOne")
            FactoryBot.create(:event, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.events_admin_events_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.events_admin_events_path

            click_link "Add New Event"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Events::Event, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Events::Event, :count)

              expect(page).to have_content("Title can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryBot.create(:event, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.events_admin_events_path

              click_link "Add New Event"

              fill_in "Title", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Events::Event, :count)

              expect(page).to have_content("There were problems")
            end
          end

          context "with translations" do
            before do
              Refinery::I18n.stub(:frontend_locales).and_return([:en, :cs])
            end

            describe "add a page with title for default locale" do
              before do
                visit refinery.events_admin_events_path
                click_link "Add New Event"
                fill_in "Title", :with => "First column"
                click_button "Save"
              end

              it "should succeed" do
                expect(Refinery::Events::Event.count).to eq(1)
              end

              it "should show locale marker for page" do
                p = Refinery::Events::Event.last
                within "#event_#{p.id}" do
                  expect(page).to have_css(".locale_marker", content: 'EN')
                end
              end

              it "should show title in the admin menu" do
                p = Refinery::Events::Event.last
                within "#event_#{p.id}" do
                  expect(page).to have_content('First column')
                end
              end
            end

            describe "add a event with title for primary and secondary locale" do
              before do
                visit refinery.events_admin_events_path
                click_link "Add New Event"
                fill_in "Title", :with => "First column"
                click_button "Save"

                visit refinery.events_admin_events_path
                within ".actions" do
                  click_link "Edit this event"
                end
                within "#switch_locale_picker" do
                  click_link "Cs"
                end
                fill_in "Title", :with => "First translated column"
                click_button "Save"
              end

              it "should succeed" do
                expect(Refinery::Events::Event.count).to eq(1)
                expect(Refinery::Events::Event::Translation.count).to eq(2)
              end

              it "should show locale flag for page" do
                p = Refinery::Events::Event.last
                within "#event_#{p.id}" do
                  expect(page).to have_css(".locale_marker", content: 'EN')
                  expect(page).to have_css(".locale_marker", content: 'CS')
                end
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Events::Event.last
                within "#event_#{p.id}" do
                  expect(page).to have_content('First column')
                end
              end
            end

            describe "add a title with title only for secondary locale" do
              before do
                visit refinery.events_admin_events_path
                click_link "Add New Event"
                within "#switch_locale_picker" do
                  click_link "Cs"
                end

                fill_in "Title", :with => "First translated column"
                click_button "Save"
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Events::Event.last
                within "#event_#{p.id}" do
                  expect(page).to have_content('First translated column')
                end
              end

              it "should show locale flag for page" do
                p = Refinery::Events::Event.last
                within "#event_#{p.id}" do
                  expect(page).to have_css(".locale_marker", content: 'CS')
                end
              end
            end
          end

        end

        describe "edit" do
          before { FactoryBot.create(:event, :title => "A title") }

          it "should succeed" do
            visit refinery.events_admin_events_path

            within ".actions" do
              click_link "Edit this event"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            expect(page).to have_content("'A different title' was successfully updated.")
            expect(page).not_to have_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryBot.create(:event, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.events_admin_events_path

            click_link "Remove this event forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Events::Event.count).to eq(0)
          end
        end

      end
    end
  end
end
