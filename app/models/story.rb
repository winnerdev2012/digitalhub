class Story < ApplicationRecord
  has_one_attached :video
  has_one_attached :audio
  validate :has_attached_story

  def has_attached_story
    if !audio.attached? && !video.attached? && response.blank?
      errors.add(:response, :blank, message: "must be provided")
    end
  end
end
