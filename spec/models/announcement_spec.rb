require "rails_helper"

RSpec.describe Refinery::Announcements::Announcement, :type => :model do

  it "it has a tag with a title of 'news' ", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'news', narrative: "We do announcements.", tag_type: "content_type")
    announcement1 = FactoryBot.create(:announcement, title: 'Test Announcement Title')
    announcement1.tags.push(tag1)
    announcement1.save

    expect(announcement1.tags[0].title).to eq('news')
  end

  it "it has a tag with a tag_type of 'content_type'", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'news', narrative: "We do announcements.", tag_type: "content_type")
    announcement1 = FactoryBot.create(:announcement, title: 'Test Announcement Title')
    announcement1.tags.push(tag1)
    announcement1.save

    expect(announcement1.tags[0].tag_type).to eq('content_type')
  end

  it "it has a tag with a tag_type of 'topic_area'", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'news', narrative: "We do announcements.", tag_type: "content_type")
    tag2 = Refinery::Tags::Tag.create(title: 'transportation', narrative: "Transportation gets you to the announcement.", tag_type: "topic_area")
    announcement1 = FactoryBot.create(:announcement, title: 'Test Announcement Title')
    announcement1.tags.push(tag1)
    announcement1.tags.push(tag2)
    announcement1.save

    expect(announcement1.tags[1].tag_type).to eq('topic_area')
  end

  it "it MUST have a published_date", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'news', narrative: "We do announcements on a specific date.", tag_type: "content_type")
    announcement1 = FactoryBot.create(:announcement, title: 'Test Announcement Title', published_date: '02-03-2018')
    announcement1.tags.push(tag1)
    announcement1.save

    expect(announcement1.published_date.month).to eq(3)
  end
end
