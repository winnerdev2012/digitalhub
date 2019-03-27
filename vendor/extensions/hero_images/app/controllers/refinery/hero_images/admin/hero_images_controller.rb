module Refinery
  module HeroImages
    module Admin
      class HeroImagesController < ::Refinery::AdminController

        crudify :'refinery/hero_images/hero_image'

        private

        # Only allow a trusted parameter "white list" through.
        def hero_image_params
          params.require(:hero_image).permit(:title, :description, :image_id)
        end

      end
    end
  end
end
