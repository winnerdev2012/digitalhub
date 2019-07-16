module Refinery
  module Taggings
    module Admin
      class TaggingsController < ::Refinery::AdminController
        crudify :'refinery/taggings/tagging'

        def index
          @taggings = Refinery::Taggings::Tagging.all.sort {|a,b| a.tagged_item_title <=> b.tagged_item_title}
          @taggings.select! {|t| t.content_type != t.tag_title}
        end

        def destroy
          @tagging = Refinery::Taggings::Tagging.find(params[:id])
          @tagging.delete
          redirect_to taggings_admin_taggings_path
        end

        private

        def tagging_params
          params.require(:tagging).permit(:event_id, :announcement_id, :tag_id)
        end
      end
    end
  end
end
