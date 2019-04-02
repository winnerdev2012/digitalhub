module Refinery
  module Stories
    module Admin
      class StoriesController < ::Refinery::AdminController

        crudify :'refinery/stories/story',
                :title_attribute => 'title'

        private

        # Only allow a trusted parameter "white list" through.
        def story_params
          params.require(:story).permit(:title, :question, :response, :display, :submitter_name, :audio, :video)
        end
      end
    end
  end
end
