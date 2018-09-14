require "rails_helper"

RSpec.describe "Front Page", :type => :system do
  before do
    driven_by(:rack_test)
  end

  it "enables me to change languages" do
    visit "/"
    expect(page).to have_text("MetroNext")
  end
end
