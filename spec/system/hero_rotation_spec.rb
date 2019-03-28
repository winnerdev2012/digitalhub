require "rails_helper"

RSpec.describe "Hero image rotation", :type => :system do
  it "has a different hero section background image, 5 seconds after pageload, if 1 hero image is created", js: true do
    create(:page)
    hero_image = create(:hero_image)
    visit "/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with English language selected", js: true do
    create(:page)
    hero_image = create(:hero_image)
    visit "/en/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with Portugese language selected", js: true do
    create(:page)
    hero_image = create(:hero_image)
    visit "/pt/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with Spanish language selected", js: true do
    create(:page)
    hero_image = create(:hero_image)
    visit "/es/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with Chinese language selected", js: true do
    create(:page)
    hero_image = create(:hero_image)
    visit "/zh/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with French language selected", js: true do
    create(:page)
    hero_image = create(:hero_image)
    visit "/fr/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end
end