module Refinery
  module Stories
    module Admin
      class StoriesController < ::Refinery::AdminController

        crudify :'refinery/stories/story',
                :title_attribute => 'name'

        private

        # Only allow a trusted parameter "white list" through.
        def story_params
          params.require(:story).permit(:name, :question, :response, :display)
        end
      end
    end
  end
end
