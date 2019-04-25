module Refinery
  module WeighInPrompts
    module Admin
      class WeighInPromptsController < ::Refinery::AdminController

        crudify :'refinery/weigh_in_prompts/weigh_in_prompt'

        private

        # Only allow a trusted parameter "permit list" through.
        def weigh_in_prompt_params
          params.require(:weigh_in_prompt).permit(:title, :image_id, :body, :style)
        end
      end
    end
  end
end
