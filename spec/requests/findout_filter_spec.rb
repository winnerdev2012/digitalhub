require 'rails_helper'

RSpec.describe 'Findout Filter API requests' do
  let(:today) { Time.zone.now }

  describe 'GET /find-out' do
    it 'returns JSON data for the title of the first report, from a group of reports' do
      report1 = create(:report, date: today)
      report2 = create(:report, date: today)
      report3 = create(:report, date: today)
      get('/reports.json')

      json_response = JSON.parse(response.body)
      expect(json_response[0]["data"]["attributes"]["title"]).to eql(report1["title"])
    end

    it 'returns JSON data for the title of the first event, from a group of events' do
      event1 = create(:event, start: today)
      event2 = create(:event, start: today)
      event3 = create(:event, start: today)
      get('/events.json')

      json_response = JSON.parse(response.body)
      expect(json_response["events"][0]["data"]["attributes"]["title"]).to eql(event1.title)
    end

    it 'returns JSON data for the title of the third announcement, from a group of announcements' do
      announcement1 = create(:announcement, published_date: today)
      announcement2 = create(:announcement, published_date: today)
      announcement3 = create(:announcement, published_date: today)
      get('/announcements.json')

      json_response = JSON.parse(response.body)
      expect(json_response[2]["data"]["attributes"]["title"]).to eql(announcement3.title)
    end

    it 'returns the expected number of JSON reports' do
      report1 = create(:report, date: today)
      report2 = create(:report, date: today)
      report3 = create(:report, date: today)
      get('/reports.json')

      json_response = JSON.parse(response.body)
      expect(json_response.count).to eql(3)
    end

    it 'returns the expected number of JSON announcements' do
      announcement1 = create(:announcement, published_date: today)
      announcement2 = create(:announcement, published_date: today)
      announcement3 = create(:announcement, published_date: today)
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
      announcement1 = create(:announcement, published_date: today)
      get("/announcements/#{announcement1.id}.json")

      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['title']).to eql(announcement1.title)
    end

    it 'returns JSON data for a specific event' do
      event1 = create(:event, start: today)

      get("/events/#{event1.id}.json")

      json_response = JSON.parse(response.body)
      expect(json_response['data']['attributes']['title']).to eql(event1.title)
    end

    it 'returns JSON data for a specific report' do
      report1 = create(:report, date: today)
      report2 = create(:report, date: today)
      report3 = create(:report, date: today)
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
  end
end
