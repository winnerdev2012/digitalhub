module Refinery
  module Stories
    class Story < Refinery::Core::BaseModel
      self.table_name = 'refinery_stories'
      has_one_attached :video
      has_one_attached :audio
      validate :has_attached_story
      before_validation :generate_title
      after_save :create_transcript
      after_initialize :set_position
      enum question: [:question1, :question2]

      extend Mobility
      translates :response

      validates :title, :presence => true, :uniqueness => true

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

      def has_attached_story
        if !audio.attached? && !video.attached? && response.blank?
          errors.add(:response, :blank, message: "must be provided")
        end
      end

      def text_response
        !audio.attached? && !video.attached?
      end

      private
      def create_transcript
        if response.blank? && !audio.attached? && video.attached?
          AudioExtractionWorker.perform_async(id)
        elsif response.blank? && audio.attached?
          TranscriptionWorker.perform_async(id)
        end
      end

      def generate_title
        return nil if question.blank? || submitter_name.blank?
        self.title = submitter_name + ' | ' + question
      end

      def set_position
        self.position ||= Story.maximum('position') ? Story.maximum('position') + 1 : 0
      end
    end
  end
end
