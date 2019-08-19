require "rails_helper"

RSpec.describe Refinery::Reports::Report, :type => :model do
  let(:test_report_date) { Time.zone.now }

  it "it has a tag of 'publications' ", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'publications', narrative: "We do reports and publications.", tag_type: "content_type")
    report1 = Refinery::Reports::Report.new(title: "The New Orthodoxy", date: test_report_date)
    report1.tags.push(tag1)
    report1.save

    expect(report1.tags[0].title).to eq('publications')
  end

  it "it has a tag with a tag_type of 'content_type'", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'publications', narrative: "We do reports and publications.", tag_type: "content_type")
    report1 = Refinery::Reports::Report.new(title: "The New Orthodoxy", date: test_report_date)
    report1.tags.push(tag1)
    report1.save

    expect(report1.tags[0].tag_type).to eq('content_type')
  end

  it "it has a tag with a tag_type of 'topic_area'", js: true do
    tag1 = Refinery::Tags::Tag.create(title: 'publications', narrative: "We do reports and publications.", tag_type: "content_type")
    tag2 = Refinery::Tags::Tag.create(title: 'transportation', narrative: "Transportation gets you from here to there.", tag_type: "topic_area")
    report1 = Refinery::Reports::Report.new(title: "The New Orthodoxy", date: test_report_date)
    report1.tags.push(tag1)
    report1.tags.push(tag2)
    report1.save

    expect(report1.tags[1].tag_type).to eq('topic_area')
  end

  it "it MUST have a date", js: true do
    event = FactoryBot.build(:report, title: 'Test title', date: nil)
    event.valid?

    expect(event.errors[:date]).to include("can't be blank")
  end
end
