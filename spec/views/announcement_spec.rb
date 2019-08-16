require "rails_helper"

RSpec.describe "Announcement Show Page", :type => :system do
  it "renders a show page for an announcement at the expected url", js: true do
    create(:page)
    announcement = create(:announcement, published_date: Time.zone.now)

    visit "/announcements/#{announcement.id}"
    expect(page).to have_text(announcement.title)
  end
end
