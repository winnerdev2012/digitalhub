module Refinery
  module Announcements
    class AnnouncementsController < ::ApplicationController

      def index
        @announcements = ::Refinery::Announcements::Announcement.all
        render json: @announcements
      end

    end
  end
end
