require "rails_helper"

RSpec.describe Refinery::Taggings::Tagging, :type => :model do
  it "it can have an associated instance of the EVENT model" do
    new_tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    new_event = FactoryBot.create(:event, title: 'Event title here')
    Refinery::Taggings::Tagging.create(tag_id: new_tag.id, event_id: new_event.id)

    expect(new_tag.events.first).to eq(new_event)
  end
    
  it "it can have an associated instance of the ANNOUNCEMENT model" do
    new_tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    new_announcement = FactoryBot.create(:announcement, title: 'Announcing the following announcement!')
    Refinery::Taggings::Tagging.create(tag_id: new_tag.id, announcement_id: new_announcement.id)

    expect(new_tag.announcements.first).to eq(new_announcement)
  end
  
  it "it MUST have an associated model instance" do
    new_tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    new_tagging = Refinery::Taggings::Tagging.create(tag_id: new_tag.id)
 
    expect(new_tagging.errors.messages[:tagged_item_title][0]).to eq("can't be blank")
  end
end
