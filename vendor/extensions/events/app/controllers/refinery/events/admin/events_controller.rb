module Refinery
  module Events
    module Admin
      class EventsController < ::Refinery::AdminController

        crudify :'refinery/events/event'

        def create
          @event = Refinery::Events::Event.create(event_params)
          if params[:tag]
            tags = params[:tag][:tag_ids].each do |tid|
              Refinery::Taggings::Tagging.create(event_id: @event.id, tag_id: tid.to_i)
            end
          end
          @event.save
          redirect_to events_admin_events_path and return
        end

        def update
          @event = Refinery::Events::Event.find(params[:id])
          @event.taggings.each {|t| t.delete}
          tags = params[:tag][:tag_ids].each do |tid|
            new_tagging = Refinery::Taggings::Tagging.create(event_id: @event.id, tag_id: tid.to_i)
          end
          redirect_to taggings_admin_taggings_path and return
        end

        private

        # Only allow a trusted parameter "white list" through.
        def event_params
          params.require(:event).permit(:title, :description, :start, :end, :image_id, :event_type, :address, :city, :state, :zipcode, :registration_link, :accessibility_note, :translation_note, :browser_title, :meta_description, :location_name, :tag)
        end
      end
    end
  end
end
