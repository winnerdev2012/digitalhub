require 'rails_helper'

RSpec.describe 'Findout Filter API requests' do
  let(:today) { Time.zone.now }

  describe 'GET /find-out' do
    it 'returns JSON data for the title of the first report, from a group of reports' do
      report1 = create(:report)
      report2 = create(:report)
      report3 = create(:report)
      get('/reports.json')

      json_response = JSON.parse(response.body)
      expect(json_response[0]["data"]["attributes"]["title"]).to eql(report1["title"])
    end

    it 'returns JSON data for the title of the first event, from a group of events' do
      event1 = create(:event)
      event2 = create(:event)
      event3 = create(:event)
      get('/events.json')

      json_response = JSON.parse(response.body)
      expect(json_response["events"][0]["data"]["attributes"]["title"]).to eql(event1.title)
    end

    it 'returns JSON data for the title of the third announcement, from a group of announcements' do
      announcement1 = create(:announcement)
      announcement2 = create(:announcement)
      announcement3 = create(:announcement)
      get('/announcements.json')

      json_response = JSON.parse(response.body)
      expect(json_response[2]["data"]["attributes"]["title"]).to eql(announcement3.title)
    end

    it 'returns the expected number of JSON reports' do
      report1 = create(:report)
      report2 = create(:report)
      report3 = create(:report)
      get('/reports.json')

      json_response = JSON.parse(response.body)
      expect(json_response.count).to eql(3)
    end

    it 'returns the expected number of JSON announcements' do
      announcement1 = create(:announcement)
      announcement2 = create(:announcement)
      announcement3 = create(:announcement)
      get('/announcements.json')

      json_response = JSON.parse(response.body)
      expect(json_response.count).to eql(3)
    end

    it 'returns the expected number of JSON events' do
      event_today = create(:event, start: today)
      event_past = create(:event, start: today - 86400)
      event_future = create(:event, start: today + 86400)
      event_upcoming = create(:event, start: today + (32 * 86400))
      get('/events.json')

      json_response = JSON.parse(response.body)
      expect(json_response["events"].count).to eql(4)
    end

    it 'returns JSON data for a specific announcement' do
      announcement1 = create(:announcement)
      announcement2 = create(:announcement)
      announcement3 = create(:announcement)
      get("/announcements/#{announcement2.id}.json")

      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['title']).to eql(announcement2.title)
    end

    it 'returns JSON data for a specific event' do
      event1 = create(:event)
      event2 = create(:event)
      event3 = create(:event)
      get("/events/#{event2.id}.json")

      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['title']).to eql(event2.title)
    end

    it 'returns JSON data for a specific report' do
      report1 = create(:report)
      report2 = create(:report)
      report3 = create(:report)
      get("/reports/#{report2.id}.json")

      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['title']).to eql(report2.title)
    end

    it 'returns past, present, future and upcoming events' do
      event_today = create(:event, start: today)
      event_past = create(:event, start: today - 86400)
      event_next = create(:event, start: today + 86400)
      event_upcoming = create(:event, start: today + (21 * 86400))
      get('/events.json')

      json_response = JSON.parse(response.body)
      expect(event_past.start.day).to eql(event_today.start.day - 1)
      expect(event_next.start.day).to eql(event_today.start.day + 1)
      expect(event_upcoming.start.month).to eql(event_today.start.month + 1)
    end

    it 'loads the find-out page', js: :true do
      create(:page)
      event1 = create(:event)
      event2 = create(:event)

      report1 = create(:report)
      report2 = create(:report)
      announcement1 = create(:announcement)
      announcement2 = create(:announcement)
      visit "/find-out"

      expect(page).to have_xpath('.//div[@id="find-out__topic-area-narrative"]')
      expect(page).to have_xpath('.//div[@class="find-out__filter"]')
      expect(page).to have_xpath('.//div[@class="FindOut"]')
    end
  end
end
