module Refinery
  module Stories
    class Story < Refinery::Core::BaseModel
      self.table_name = 'refinery_stories'
      has_one_attached :video
      has_one_attached :audio
      validate :has_attached_story
      after_save :create_transcript
      enum question: [:question1, :question2, :question3]

      extend Mobility
      translates :response

      validates :name, :presence => true, :uniqueness => true

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

      def has_attached_story
        if !audio.attached? && !video.attached? && response.blank?
          errors.add(:response, :blank, message: "must be provided")
        end
      end

      private
      def create_transcript
        if response.blank? && !audio.attached? && video.attached?
          AudioExtractionWorker.perform_async(id)
        elsif response.blank? && audio.attached?
          TranscriptionWorker.perform_async(id)
        end
      end
    end
  end
end