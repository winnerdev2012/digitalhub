require "rails_helper"

RSpec.describe "Hero image rotation", :type => :system do
  it "has a different hero section background image, 5 seconds after pageload, if 1 hero image is created", js: true do
    create(:page)
    create(:hero_image, image: build(:alternate_image))
    Capybara.current_session.driver.browser.manage.window.resize_to(1440, 1000)
    visit "/"
    # puts page.find(:xpath, '//*[@id="page"]/div/section[1]/div[1]/div[1]')['innerHTML']
    sleep 5
    puts page.find(:xpath, '//*[@id="page"]/div/section[1]/div[1]/div[1]')['innerHTML']
    expect(page).to have_xpath('//div[contains(@style,"beach-alternate.jpeg")]')
  end

  it "works with English language selected", js: true do
    create(:page)
    create(:hero_image, image: build(:alternate_image))
    Capybara.current_session.driver.browser.manage.window.resize_to(1440, 1000)
    visit "/en/"
    sleep 5
    expect(page).to have_xpath('//div[contains(@style,"beach-alternate.jpeg")]')
  end

  it "works with Portugese language selected", js: true do
    create(:page)
    create(:hero_image, image: build(:alternate_image))
    Capybara.current_session.driver.browser.manage.window.resize_to(1440, 1000)
    visit "/pt/"
    sleep 5
    expect(page).to have_xpath('//div[contains(@style,"beach-alternate.jpeg")]')
  end

  it "works with Spanish language selected", js: true do
    create(:page)
    create(:hero_image, image: build(:alternate_image))
    Capybara.current_session.driver.browser.manage.window.resize_to(1440, 1000)
    visit "/es/"
    sleep 5
    expect(page).to have_xpath('//div[contains(@style,"beach-alternate.jpeg")]')
  end

  it "works with Chinese language selected", js: true do
    create(:page)
    create(:hero_image, image: build(:alternate_image))
    Capybara.current_session.driver.browser.manage.window.resize_to(1440, 1000)
    visit "/zh/"
    sleep 5
    expect(page).to have_xpath('//div[contains(@style,"beach-alternate.jpeg")]')
  end

  it "works with French language selected", js: true do
    create(:page)
    create(:hero_image, image: build(:alternate_image))
    Capybara.current_session.driver.browser.manage.window.resize_to(1440, 1000)
    visit "/fr/"
    sleep 5
    expect(page).to have_xpath('//div[contains(@style,"beach-alternate.jpeg")]')
  end
end
