require "rails_helper"

RSpec.describe Refinery::Tags::Tag, :type => :model do
  let(:test_date) { Time.zone.now }

  it "has a title" do
    new_tag = FactoryBot.create(:tag, title: 'TagTitle3', tag_type: "topic_area")

    expect(new_tag.title).to eq("TagTitle3")
  end

  it "has a tag_type" do
    new_tag = FactoryBot.create(:tag, title: 'TagTitle2', tag_type: "topic_area")

    expect(new_tag.tag_type).to eq("topic_area")
  end

  it "can have many taggings" do
    tag1 = FactoryBot.create(:tag, title: 'publications', tag_type: "content_type")
    tag2 = FactoryBot.create(:tag, title: 'housing', tag_type: "topic_area")

    report1 = FactoryBot.create(:report, title: "When the dogs come back.", date: test_date)
    report2 = FactoryBot.create(:report, title: "When the cats leave.", date: test_date)
    report3 = FactoryBot.create(:report, title: "When the horses run.", date: test_date)

    report1.tags.push(tag1)
    report1.tags.push(tag2)
    report1.save

    report2.tags.push(tag1)
    report2.tags.push(tag2)
    report2.save

    report3.tags.push(tag1)
    report3.tags.push(tag2)
    report3.save

    expect(tag2.taggings.count).to eq(3)
  end
end
