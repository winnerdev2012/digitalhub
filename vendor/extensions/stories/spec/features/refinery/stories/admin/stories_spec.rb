# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Stories" do
    describe "Admin" do
      describe "stories", type: :feature do
        refinery_login

        describe "stories list" do
          before do
            FactoryBot.create(:story, :name => "UniqueTitleOne")
            FactoryBot.create(:story, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.stories_admin_stories_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.stories_admin_stories_path

            click_link "Add New Story"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "name", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Stories::Story, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Stories::Story, :count)

              expect(page).to have_content("name can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryBot.create(:story, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.stories_admin_stories_path

              click_link "Add New Story"

              fill_in "name", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Stories::Story, :count)

              expect(page).to have_content("There were problems")
            end
          end

          context "with translations" do
            before do
              Refinery::I18n.stub(:frontend_locales).and_return([:en, :cs])
            end

            describe "add a page with title for default locale" do
              before do
                visit refinery.stories_admin_stories_path
                click_link "Add New Story"
                fill_in "name", :with => "First column"
                click_button "Save"
              end

              it "should succeed" do
                expect(Refinery::Stories::Story.count).to eq(1)
              end

              it "should show locale marker for page" do
                p = Refinery::Stories::Story.last
                within "#story_#{p.id}" do
                  expect(page).to have_css(".locale_marker", content: 'EN')
                end
              end

              it "should show name in the admin menu" do
                p = Refinery::Stories::Story.last
                within "#story_#{p.id}" do
                  expect(page).to have_content('First column')
                end
              end
            end

            describe "add a story with title for primary and secondary locale" do
              before do
                visit refinery.stories_admin_stories_path
                click_link "Add New Story"
                fill_in "name", :with => "First column"
                click_button "Save"

                visit refinery.stories_admin_stories_path
                within ".actions" do
                  click_link "Edit this story"
                end
                within "#switch_locale_picker" do
                  click_link "Cs"
                end
                fill_in "name", :with => "First translated column"
                click_button "Save"
              end

              it "should succeed" do
                expect(Refinery::Stories::Story.count).to eq(1)
                expect(Refinery::Stories::Story::Translation.count).to eq(2)
              end

              it "should show locale flag for page" do
                p = Refinery::Stories::Story.last
                within "#story_#{p.id}" do
                  expect(page).to have_css(".locale_marker", content: 'EN')
                  expect(page).to have_css(".locale_marker", content: 'CS')
                end
              end

              it "should show name in backend locale in the admin menu" do
                p = Refinery::Stories::Story.last
                within "#story_#{p.id}" do
                  expect(page).to have_content('First column')
                end
              end
            end

            describe "add a name with title only for secondary locale" do
              before do
                visit refinery.stories_admin_stories_path
                click_link "Add New Story"
                within "#switch_locale_picker" do
                  click_link "Cs"
                end

                fill_in "name", :with => "First translated column"
                click_button "Save"
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Stories::Story.last
                within "#story_#{p.id}" do
                  expect(page).to have_content('First translated column')
                end
              end

              it "should show locale flag for page" do
                p = Refinery::Stories::Story.last
                within "#story_#{p.id}" do
                  expect(page).to have_css(".locale_marker", content: 'CS')
                end
              end
            end
          end

        end

        describe "edit" do
          before { FactoryBot.create(:story, :name => "A name") }

          it "should succeed" do
            visit refinery.stories_admin_stories_path

            within ".actions" do
              click_link "Edit this story"
            end

            fill_in "name", :with => "A different name"
            click_button "Save"

            expect(page).to have_content("'A different name' was successfully updated.")
            expect(page).not_to have_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryBot.create(:story, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.stories_admin_stories_path

            click_link "Remove this story forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Stories::Story.count).to eq(0)
          end
        end

      end
    end
  end
end
