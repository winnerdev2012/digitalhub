class StorySerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :submitter_name, :question, :position, :display, :response, :video, :audio
end
