require "rails_helper"

RSpec.describe Refinery::Tags::Tag, :type => :model do
  it "has a title" do
    new_tag = FactoryBot.create(:tag, title: 'TagTitle3', tag_type: "topic_area")

    expect(new_tag.title).to eq("TagTitle3")
  end

  it "has a tag_type" do
    new_tag = FactoryBot.create(:tag, title: 'TagTitle2', tag_type: "topic_area")

    expect(new_tag.tag_type).to eq("topic_area")
  end
  
  it "can have many taggings" do 
    new_tag = FactoryBot.create(:tag, title: 'Waste Management Video', tag_type: "content_type")
    new_event = FactoryBot.create(:event, title: "What I did last summer")
    new_announcement = FactoryBot.create(:announcement, title: "What I ate last night")
    new_report = Refinery::Reports::Report.create(title: "When the dogs come back.", image: FactoryBot.create(:image))
 
    Refinery::Taggings::Tagging.create(tag_id: new_tag.id, event_id: new_event.id)
    Refinery::Taggings::Tagging.create(tag_id: new_tag.id, announcement_id: new_announcement.id)
    Refinery::Taggings::Tagging.create(tag_id: new_tag.id, report_id: new_report.id)
  
    expect(new_tag.taggings.count).to eq(3)
  end
end
