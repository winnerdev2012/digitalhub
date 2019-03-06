require "rails_helper"

RSpec.describe "Front Page", :type => :system do
  it "enables me to view the front page", :browserstack do
    create(:page)
    visit "/"
    expect(page).to have_text("Welcome to MetroCommon 2050!")
  end
end
