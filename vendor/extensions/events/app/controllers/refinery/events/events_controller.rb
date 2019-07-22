module Refinery
  module Events
    class EventsController < ::ApplicationController

      before_action :find_all_events
      before_action :find_page

      def index
        events_json = @events.map { |event| EventSerializer.new(event, { :include => [:image] }).serializable_hash }
        @upcoming_events = ::Refinery::Events::Event.where(start: DateTime.now..DateTime.now.at_end_of_month).order(start: :asc)
        @events_next_month = ::Refinery::Events::Event.where(start: DateTime.now.at_beginning_of_month.next_month..DateTime.now.at_end_of_month.next_month)
        @past_events = ::Refinery::Events::Event.where('start < ?', DateTime.now).order(start: :desc)

        respond_to do |f|
          f.html { present(@page) }
          f.json { render json: { events: events_json, past: @past_events, next: @events_next_month, upcoming: @upcoming_events }}
        end
      end

      def show
        @event = ::Refinery::Events::Event.find(params[:id])
        event_json = EventSerializer.new(@event, { :include => [:image] }).serializable_hash

        respond_to do |f|
          f.html { present(@page) }
          f.json { render json: event_json }
        end
      end

    protected

      def find_all_events
        @events = Event.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(link_url: "/events").first
      end

    end
  end
end
