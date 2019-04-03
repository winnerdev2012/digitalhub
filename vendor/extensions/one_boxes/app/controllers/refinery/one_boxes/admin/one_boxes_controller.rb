module Refinery
  module OneBoxes
    module Admin
      class OneBoxesController < ::Refinery::AdminController

        crudify :'refinery/one_boxes/one_box'

        private

        # Only allow a trusted parameter "white list" through.
        def one_box_params
          params.require(:one_box).permit(:title, :visible, :triangle_overlay, :image_id, :link)
        end
      end
    end
  end
end
