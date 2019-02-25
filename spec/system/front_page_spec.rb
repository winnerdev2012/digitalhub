require "rails_helper"

RSpec.describe "Front Page", :type => :system do
  context "changing languages" do

    it "enables me to view the page in portugese", js: true do
      create(:page)
      visit "/"
      expect(page).to have_text("MetroNext")
    end

  end
end
