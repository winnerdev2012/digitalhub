module Refinery
  module WeighInPrompts
    class WeighInPrompt < Refinery::Core::BaseModel
      self.table_name = 'refinery_weigh_in_prompts'
      enum style: [:large, :small]
      after_initialize :set_position


      validates :title, :presence => true, :uniqueness => true

      belongs_to :image, :class_name => '::Refinery::Image'

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

      private

      def set_position
        self.position ||= WeighInPrompt.maximum('position') ? WeighInPrompt.maximum('position') + 1 : 0
      end

    end
  end
end
