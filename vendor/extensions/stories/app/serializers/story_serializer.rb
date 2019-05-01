class StorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :submitter_name, :question, :position, :display, :response, :video, :audio, :text_response

  attribute :sanitized_response do |story|
    ActionController::Base.helpers.strip_tags(story.response)
  end
end
