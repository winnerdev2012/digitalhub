module Refinery
  module Events
    class EventsController < ::ApplicationController

      before_action :find_all_events
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        now = DateTime.now
        now_nozone = DateTime.new(now.year, now.month, now.day, now.hour, now.minute, now.second)
        in_next_year, next_month = (now_nozone.month + 1).divmod(12)
        year = in_next_year > 0 ? now_nozone.year + 1 : now_nozone.year
        beginning_of_next_month = DateTime.new(year, next_month, 1, 0, 0, 0)
        end_of_next_month = DateTime.new(year, next_month, -1, -1, -1, -1)

        @upcoming_events = ::Refinery::Events::Event.where(start: now_nozone..beginning_of_next_month)
        @events_next_month = ::Refinery::Events::Event.where(start: beginning_of_next_month..end_of_next_month)
        present(@page)
      end

      def show
        @event = Event.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
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
