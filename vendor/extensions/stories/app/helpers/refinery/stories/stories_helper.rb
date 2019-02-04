module Refinery
  module Stories
    module StoriesHelper
      def question_text(enum)
        if enum === 'question1'
          'Congratulations! You get to ask someone in the year 2050 about what life is like! What do you want to know?'
        elsif enum === 'question2'
          'In your dream future, what do you want life to be like for children when it comes to housing?'
        else
          'No question was selected.'
        end
      end
    end
  end
end
