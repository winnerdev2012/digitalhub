require "rails_helper"

RSpec.describe Refinery::Taggings::Tagging, :type => :model do
  let(:test_date) { Time.zone.now }

  it "it can have an associated instance of the REPORT model" do
    tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    report = FactoryBot.create(:report, title: 'Reporting the following report!', date: test_date)
    Refinery::Taggings::Tagging.create(tag_id: tag.id, report_id: report.id)

    expect(tag.reports.first).to eq(report)
  end

  it "it can have an associated instance of the EVENT model" do
    tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    event = FactoryBot.create(:event, title: 'The main event!', start: test_date)
    Refinery::Taggings::Tagging.create(tag_id: tag.id, event_id: event.id)

    expect(tag.events.first).to eq(event)
  end

  it "it can have an associated instance of the ANNOUNCEMENT model" do
    tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    announcement = FactoryBot.create(:announcement, title: 'The main announcement!', published_date: test_date)
    Refinery::Taggings::Tagging.create(tag_id: tag.id, announcement_id: announcement.id)

    expect(tag.announcements.first).to eq(announcement)
  end

  it "it MUST be associated to a tag and a model instance" do
    tag = FactoryBot.create(:tag, title: 'animals', tag_type: "topic_area")
    tagging = Refinery::Taggings::Tagging.create(tag_id: tag.id)

    expect(tagging.errors.messages[:has_tagged_item?]).to include("tagging must have tagged model instance")
  end
end
