require "rails_helper"

RSpec.describe Refinery::Taggings::Tagging, :type => :model do
  it "it can have an associated instance of the REPORT model" do
    tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    report = FactoryBot.create(:report, title: 'Reporting the following report!')
    Refinery::Taggings::Tagging.create(tag_id: tag.id, report_id: report.id)

    expect(tag.reports.first).to eq(report)
  end

  it "it can have an associated instance of the EVENT model" do
    tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    event = FactoryBot.create(:event, title: 'The main event!')
    Refinery::Taggings::Tagging.create(tag_id: tag.id, event_id: event.id)

    expect(tag.events.first).to eq(event)
  end

  it "it MUST be associated to a tag and a model instance" do
    tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    tagging = Refinery::Taggings::Tagging.create(tag_id: tag.id)

    expect(tagging.errors.messages[:has_tagged_item?]).to include("tagging must have tagged model instance")
    # expect(tagging.has_tagged_item?).to be(nil)
  end
end
