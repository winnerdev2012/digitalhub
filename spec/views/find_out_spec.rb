require "rails_helper"

RSpec.describe "Find Out Page", :type => :system do
  it "renders the Find Out page", js: true do
    create(:page)

    visit "/find-out"
    expect(page).to have_text('There are currently no results ')
  end
end
