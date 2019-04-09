require "rails_helper"

RSpec.describe "Hero image truncate and seed", :type => :system do
  it "deletes all of the hero_images" do
    ::Refinery::HeroImages::HeroImage.delete_all
    hero_image_count = ::Refinery::HeroImages::HeroImage.all.count
    expect(hero_image_count).to eq(0)
  end

  it "loads all of the .jpg files from app/vendor/extensions/hero_images/lib/import" do
    count = Dir[Rails.root.join('vendor', 'extensions', 'hero_images', 'lib', 'import', '*')].count
    ::Refinery::HeroImages::Engine.load_seed
    hero_image_count = ::Refinery::HeroImages::HeroImage.all.count
    expect(hero_image_count).to eq(count)
  end
end
