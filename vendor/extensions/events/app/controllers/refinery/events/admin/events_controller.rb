module Refinery
  module Events
    module Admin
      class EventsController < ::Refinery::AdminController

        crudify :'refinery/events/event'

        private

        # Only allow a trusted parameter "white list" through.
        def event_params
          params.require(:event).permit(:title, :description, :start, :end, :image_id, :event_type, :address, :city, :state, :zipcode, :registration_link, :accessibility_note, :translation_note, :browser_title, :meta_description)
        end
      end
    end
  end
end
