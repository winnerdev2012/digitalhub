module Refinery
  module Stories
    module StoriesHelper
      def question_text(enum)
        if enum === 'question1'
          'Congratulations! You get to ask someone in the year 2050 about what life is like! What do you want to know?'
        elsif enum === 'question2'
          'In your ideal future, what do you want life to be like? (Feel free to talk about specific groups like children or seniors, and specific issues like housing or transportation.)'
        else
          'No question was selected.'
        end
      end

      def audio_question_text(enum)
        if enum === 'question1'
          'In 2050...'
        elsif enum === 'question2'
          'Ask the Future'
        else
          'No question was selected.'
        end
      end
    end
  end
end
