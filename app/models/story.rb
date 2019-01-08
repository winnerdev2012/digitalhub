class Story < ApplicationRecord
  has_one_attached :video
  has_one_attached :audio
  validate :has_attached_story
  after_save :create_transcript

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
