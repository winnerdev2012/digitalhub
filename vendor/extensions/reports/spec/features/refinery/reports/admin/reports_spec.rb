# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Reports" do
    describe "Admin" do
      describe "reports", type: :feature do
        refinery_login

        describe "reports list" do
          before do
            FactoryBot.create(:report, :title => "UniqueTitleOne")
            FactoryBot.create(:report, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.reports_admin_reports_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.reports_admin_reports_path

            click_link "Add New Report"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Reports::Report, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Reports::Report, :count)

              expect(page).to have_content("Title can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryBot.create(:report, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.reports_admin_reports_path

              click_link "Add New Report"

              fill_in "Title", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Reports::Report, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryBot.create(:report, :title => "A title") }

          it "should succeed" do
            visit refinery.reports_admin_reports_path

            within ".actions" do
              click_link "Edit this report"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            expect(page).to have_content("'A different title' was successfully updated.")
            expect(page).not_to have_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryBot.create(:report, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.reports_admin_reports_path

            click_link "Remove this report forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Reports::Report.count).to eq(0)
          end
        end

      end
    end
  end
end
