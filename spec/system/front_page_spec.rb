require "rails_helper"

RSpec.describe "Front Page", :type => :system do
  it "enables me to view the front page", :browserstack do
    create(:page)
    visit "/"
    expect(page).to have_text("Welcome to MetroCommon")
  end

  it "footer is accessible", js: true do
    pending 'waiting for button update'
    create(:page)
    visit "/"
    expect(page).to be_accessible.within '.footer'
  end
end
