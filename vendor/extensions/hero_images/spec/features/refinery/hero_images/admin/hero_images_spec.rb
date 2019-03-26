# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "HeroImages" do
    describe "Admin" do
      describe "hero_images", type: :feature do
        refinery_login

        describe "hero_images list" do
          before do
            FactoryBot.create(:hero_image, :title => "UniqueTitleOne")
            FactoryBot.create(:hero_image, :title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.hero_images_admin_hero_images_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.hero_images_admin_hero_images_path

            click_link "Add New Hero Image"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::HeroImages::HeroImage, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::HeroImages::HeroImage, :count)

              expect(page).to have_content("Title can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryBot.create(:hero_image, :title => "UniqueTitle") }

            it "should fail" do
              visit refinery.hero_images_admin_hero_images_path

              click_link "Add New Hero Image"

              fill_in "Title", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::HeroImages::HeroImage, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryBot.create(:hero_image, :title => "A title") }

          it "should succeed" do
            visit refinery.hero_images_admin_hero_images_path

            within ".actions" do
              click_link "Edit this hero image"
            end

            fill_in "Title", :with => "A different title"
            click_button "Save"

            expect(page).to have_content("'A different title' was successfully updated.")
            expect(page).not_to have_content("A title")
          end
        end

        describe "destroy" do
          before { FactoryBot.create(:hero_image, :title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.hero_images_admin_hero_images_path

            click_link "Remove this hero image forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::HeroImages::HeroImage.count).to eq(0)
          end
        end

      end
    end
  end
end
