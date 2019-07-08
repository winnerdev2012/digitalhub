module Refinery
  module Tags
    module Admin
      class TagsController < ::Refinery::AdminController

        crudify :'refinery/tags/tag'

        def create
          @tag = Refinery::Tags::Tag.create(tag_params)
          redirect_to tags_admin_tags_path and return
        end

        private

        # Only allow a trusted parameter "permit list" through.
        def tag_params
          params.require(:tag).permit(:title, :tag_type)
        end
      end
    end
  end
end
