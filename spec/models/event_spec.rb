require "rails_helper"

RSpec.describe Refinery::Events::Event, :type => :model do

  it "it has a tag with title 'events' ", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'events', narrative: "We do events.", tag_type: "content_type")
    event1 = FactoryBot.create(:event, title: 'Test Event Title')
    event1.tags.push(tag1)
    event1.save

    expect(event1.tags[0].title).to eq('events')
  end

  it "it has a tag with a tag_type of 'content_type'", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'events', narrative: "We do events.", tag_type: "content_type")
    event1 = FactoryBot.create(:event, title: 'Test Event Title')
    event1.tags.push(tag1)
    event1.save

    expect(event1.tags[0].tag_type).to eq('content_type')
  end

  it "it has a tag with a tag_type of 'topic_area'", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'events', narrative: "We do events.", tag_type: "content_type")
    tag2 = Refinery::Tags::Tag.create(title: 'transportation', narrative: "Transportation gets you to the event.", tag_type: "topic_area")
    event1 = FactoryBot.create(:event, title: 'Test Event Title')
    event1.tags.push(tag1)
    event1.tags.push(tag2)
    event1.save

    expect(event1.tags[1].tag_type).to eq('topic_area')
  end
end
