module Refinery
  module Announcements
    module Admin
      class AnnouncementsController < ::Refinery::AdminController

        crudify :'refinery/announcements/announcement'

        private

        # Only allow a trusted parameter "white list" through.
        def announcement_params
          params.require(:announcement).permit(:title, :body, :image_id, :link)
        end
      end
    end
  end
end
