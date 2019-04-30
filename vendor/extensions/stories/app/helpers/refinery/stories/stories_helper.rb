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

      def next_prompt(current_prompt)
        if current_prompt[:prompt] == 'small'
          {"prompt": "large"}
        else
          {"prompt": "small"}
        end
      end

      def insert_prompts(stories)
        stories_array = stories.to_a
        current_prompt = {"prompt": "large"}
        stories_array.insert(1, current_prompt)
        stories_index_array = (0..stories.length-1).to_a

        stories_array.each_with_index do |story, index|
          if index % 5 == 0 && index != 0
            current_prompt = next_prompt(current_prompt)
            stories_array.insert(index, current_prompt)
          end
        end
        stories_array
      end
    end
  end
end
