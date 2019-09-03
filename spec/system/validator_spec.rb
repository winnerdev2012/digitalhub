require "rails_helper"

RSpec.describe "Validator", :type => :system do
  let(:test_date) { Time.zone.now }

  it "finds an invalid announcement" do
    tag_news = Refinery::Tags::Tag.create(title: 'news', narrative: "We do announcements.", tag_type: "content_type")
    announcement = FactoryBot.build(:announcement, title: 'Test Announcement Title', published_date: nil)
    announcement.tags.push(tag_news)
    announcement.save(:validate => false)

    visit "/data_validation"
    expect(page).to have_text("Published date can't be blank")
  end

  it "confirms all announcements valid" do
    tag_news = Refinery::Tags::Tag.create(title: 'news', narrative: "We do announcements.", tag_type: "content_type")
    announcement1 = FactoryBot.build(:announcement, title: 'Test Announcement Title1', published_date: test_date)
    announcement1.tags.push(tag_news)
    announcement1.save

    announcement2 = FactoryBot.build(:announcement, title: 'Test Announcement Title2', published_date: test_date + 1)
    announcement2.tags.push(tag_news)
    announcement2.save

    announcement3 = FactoryBot.build(:announcement, title: 'Test Announcement Title3', published_date: test_date + 3)
    announcement3.tags.push(tag_news)
    announcement3.save

    visit "/data_validation"
    expect(page).to have_text("all announcements valid")
  end

  it "finds an invalid event" do
    tag_event = Refinery::Tags::Tag.create(title: 'publication', narrative: "Read the report.", tag_type: "content_type")
    event = FactoryBot.build(:event, title: 'Test Event Title', start: nil)
    event.tags.push(tag_event)
    event.save(:validate => false)

    visit "/data_validation"
    expect(page).to have_text("Start can't be blank")
  end

  it "confirms all events valid" do
    tag_event = Refinery::Tags::Tag.create(title: 'event', narrative: "We do events.", tag_type: "content_type")
    event1 = FactoryBot.build(:event, title: 'Test Announcement Title1', start: test_date)
    event1.tags.push(tag_event)
    event1.save

    event2 = FactoryBot.build(:event, title: 'Test Announcement Title2', start: test_date + 1)
    event2.tags.push(tag_event)
    event2.save

    event3 = FactoryBot.build(:event, title: 'Test Announcement Title3', start: test_date + 3)
    event3.tags.push(tag_event)
    event3.save

    visit "/data_validation"
    expect(page).to have_text("all events valid")
  end

  it "finds an invalid hero_image" do
    hero_image = FactoryBot.build(:hero_image, image: nil)
    hero_image.save(:validate => false)

    visit "/data_validation"
    expect(page).to have_text("Image must exist")
  end

  it "confirms all hero_imagees valid" do
    hero_image1 = FactoryBot.create(:hero_image)
    hero_image2 = FactoryBot.create(:hero_image)
    hero_image3 = FactoryBot.create(:hero_image)

    visit "/data_validation"
    expect(page).to have_text("all hero_images valid")
  end

  it "finds an invalid one_box" do
    one_box = FactoryBot.build(:one_box, title: 'Test Announcement Title', image: nil)
    one_box.save(:validate => false)

    visit "/data_validation"
    expect(page).to have_text("Image must exist")
  end

  it "confirms all one_boxes valid" do
    one_box1 = FactoryBot.create(:one_box, title: 'Test OneBox Title1')
    one_box2 = FactoryBot.create(:one_box, title: 'Test OneBox Title2')
    one_box3 = FactoryBot.create(:one_box, title: 'Test OneBox Title3')

    visit "/data_validation"
    expect(page).to have_text("all one_boxes valid")
  end

  it "finds an invalid report" do
    tag_publication = Refinery::Tags::Tag.create(title: 'publication', narrative: "Read the report.", tag_type: "content_type")
    report = FactoryBot.build(:report, title: 'Test Report Title', image: nil)
    report.tags.push(tag_publication)
    report.save(:validate => false)

    visit "/data_validation"
    expect(page).to have_text("Image must exist")
  end

  it "confirms all reports valid" do
    tag_publication = Refinery::Tags::Tag.create(title: 'publication', narrative: "We do reports.", tag_type: "content_type")
    report1 = FactoryBot.build(:report, title: 'Test Announcement Title1', date: test_date)
    report1.tags.push(tag_publication)
    report1.save

    report2 = FactoryBot.build(:report, title: 'Test Announcement Title2', date: test_date + 1)
    report2.tags.push(tag_publication)
    report2.save

    report3 = FactoryBot.build(:report, title: 'Test Announcement Title3', date: test_date + 3)
    report3.tags.push(tag_publication)
    report3.save

    visit "/data_validation"
    expect(page).to have_text("all reports valid")
  end

  it "finds an invalid story" do
    story = FactoryBot.build(:story)
    story.video = nil
    story.audio = nil
    story.response = ''
    story.save(validate: false)

    visit "/data_validation"
    expect(page).to have_text("Response must be provided")
  end

  it "confirms all stories valid" do
    story1 = FactoryBot.create(:story)
    story2 = FactoryBot.create(:story)
    story3 = FactoryBot.create(:story)

    visit "/data_validation"
    expect(page).to have_text("all stories valid")
  end

  it "finds an invalid tag" do
    tag = FactoryBot.build(:tag)
    tag.save(validate: false)

    visit "/data_validation"
    expect(page).to have_text("Tag Type can't be blank")
  end

  it "confirms all tags valid" do
    tag1 = FactoryBot.create(:tag, tag_type: 'topic_area')
    tag2 = FactoryBot.create(:tag, tag_type: 'content_type')

    visit "/data_validation"
    expect(page).to have_text("all tags valid")
  end

  it "finds an invalid tag_type" do
    tag1 = FactoryBot.create(:tag, tag_type: 'topic_area')
    tag2 = FactoryBot.create(:tag, tag_type: 'content_type')
    tag3 = FactoryBot.create(:tag, tag_type: 'content_type')
    tag3.title = tag1.title
    tag3.save(:validate => false)

    visit "/data_validation"
    expect(page).to have_text("Title has already been taken")
  end

  it "finds an invalid tagging" do
    tag1 = FactoryBot.create(:tag, tag_type: 'topic_area')
    tag2 = FactoryBot.create(:tag, tag_type: 'content_type')
    report = FactoryBot.create(:report, date: test_date)
    event = FactoryBot.create(:event, start: test_date)
    announcement = FactoryBot.create(:announcement, published_date: test_date)
    tagging1 = Refinery::Taggings::Tagging.create(announcement_id: announcement.id, tag_id: tag1.id)
    tagging2 = Refinery::Taggings::Tagging.create(announcement_id: announcement.id, tag_id: tag2.id)
    tagging3 = Refinery::Taggings::Tagging.create(event_id: event.id, tag_id: tag1.id)
    tagging4 = Refinery::Taggings::Tagging.create(event_id: event.id, tag_id: tag2.id)
    tagging5 = Refinery::Taggings::Tagging.create(report_id: report.id, tag_id: tag1.id)
    tagging6 = Refinery::Taggings::Tagging.new(tag_id: tag2.id)
    tagging6.save(validate: false)

    visit "/data_validation"
    expect(page).to have_text("Tagged item title associated Active Record instance NOT found")
  end

  it "confirms all taggings valid" do
    tag1 = FactoryBot.create(:tag, tag_type: 'topic_area')
    tag2 = FactoryBot.create(:tag, tag_type: 'content_type')
    report = FactoryBot.create(:report, date: test_date)
    event = FactoryBot.create(:event, start: test_date)
    announcement = FactoryBot.create(:announcement, published_date: test_date)
    tagging1 = Refinery::Taggings::Tagging.create(announcement_id: announcement.id, tag_id: tag1.id)
    tagging2 = Refinery::Taggings::Tagging.create(announcement_id: announcement.id, tag_id: tag2.id)
    tagging3 = Refinery::Taggings::Tagging.create(event_id: event.id, tag_id: tag1.id)
    tagging4 = Refinery::Taggings::Tagging.create(event_id: event.id, tag_id: tag2.id)
    tagging5 = Refinery::Taggings::Tagging.create(report_id: report.id, tag_id: tag1.id)
    tagging6 = Refinery::Taggings::Tagging.create(report_id: report.id, tag_id: tag2.id)

    visit "/data_validation"
    expect(page).to have_text("all taggings valid")
  end
end
