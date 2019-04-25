# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "WeighInPrompts" do
    describe "Admin" do
      describe "weigh_in_prompts", type: :feature do
        refinery_login

        describe "weigh_in_prompts list" do
          before do
            FactoryBot.create(:weigh_in_prompt, :title => "UniqueTitleOne")
            FactoryBot.create(:weigh_in_prompt, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.weigh_in_prompts_admin_weigh_in_prompts_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.weigh_in_prompts_admin_weigh_in_prompts_path

            click_link "Add New Weigh In Prompt"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::WeighInPrompts::WeighInPrompt, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::WeighInPrompts::WeighInPrompt, :count)

              expect(page).to have_content("Title can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryBot.create(:weigh_in_prompt, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.weigh_in_prompts_admin_weigh_in_prompts_path

              click_link "Add New Weigh In Prompt"

              fill_in "Title", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::WeighInPrompts::WeighInPrompt, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryBot.create(:weigh_in_prompt, :title => "A title") }

          it "should succeed" do
            visit refinery.weigh_in_prompts_admin_weigh_in_prompts_path

            within ".actions" do
              click_link "Edit this weigh in prompt"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            expect(page).to have_content("'A different title' was successfully updated.")
            expect(page).not_to have_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryBot.create(:weigh_in_prompt, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.weigh_in_prompts_admin_weigh_in_prompts_path

            click_link "Remove this weigh in prompt forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::WeighInPrompts::WeighInPrompt.count).to eq(0)
          end
        end

      end
    end
  end
end
