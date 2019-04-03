require "rails_helper"

RSpec.describe "Hero image rotation", :type => :system do
  it "has a different hero section background image, 5 seconds after pageload, if 1 hero image is created", js: true do
    create(:page)
    hero_image = create(:hero_image)
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(1440, 1000) # width, height    
    visit "/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with English language selected", js: true do
    create(:page)
    hero_image = create(:hero_image)
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(1440, 1000) # width, height    
    visit "/en/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with Portugese language selected", js: true do
    create(:page)
    hero_image = create(:hero_image)
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(1440, 1000) # width, height    
    visit "/pt/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with Spanish language selected", js: true do
    create(:page)
    hero_image = create(:hero_image)
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(1440, 1000) # width, height    
    visit "/es/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with Chinese language selected", js: true do
    create(:page)
    hero_image = create(:hero_image)
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(1440, 1000) # width, height    
    visit "/zh/"
    sleep 3
    expect(page.find('div.rotation-test')[:style].split('/').last == ("beach.jpeg\");")).to be(true)
  end

  it "works with French language selected", js: true do
    create(:page)
    hero_image1 = create(:hero_image)
    hero_image2 = create(:hero_image)
    hero_image3 = create(:hero_image)
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(1440, 1000) # width, height    
    visit "/fr/"
    expect(page.has_selector?('.rotation-test')).to be(true)
  end
end