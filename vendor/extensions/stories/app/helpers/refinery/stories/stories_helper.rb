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

      def next_prompt
        if @current_prompt.nil?
          @current_prompt = @small_prompt
        elsif @current_prompt == @small_prompt
          @current_prompt = @large_prompt
        elsif @current_prompt == @large_prompt
          @current_prompt = @small_prompt
        end
      end
      
      def insert_prompts(stories)
        @current_prompt = nil
        @large_prompt = {"prompt": "large"}
        @small_prompt = {"prompt": "small"}
        
        stories_array = stories.to_a
        stories_array.insert(1, @large_prompt)
        stories_index_array = (0..stories.length-1).to_a

        stories_index_array.each.with_index do |index|
          if index % 5 == 0 && index != 0
            next_prompt
            stories_array.insert(index, @current_prompt)
          end
        end
        stories_array
      end
    end
  end
end
