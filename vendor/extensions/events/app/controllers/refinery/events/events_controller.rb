module Refinery
  module Events
    class EventsController < ::ApplicationController

      before_action :find_all_events
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:

        @upcoming_events = ::Refinery::Events::Event.where(start: DateTime.now..DateTime.now.at_end_of_month)
        @events_next_month = ::Refinery::Events::Event.where(start: DateTime.now.at_beginning_of_month.next_month..DateTime.now.at_end_of_month.next_month)
        present(@page)
        @past_events = ::Refinery::Events::Event.where('start < ?', DateTime.now)
      end

      def show
        @event = Event.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @event in the line below:
        present(@page)
      end

    private

      def story_params
        params.require(:story).permit(:name, :question, :response, :display)
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
