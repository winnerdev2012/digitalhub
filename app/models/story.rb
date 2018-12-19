class Story < ApplicationRecord
  has_one_attached :video
  has_one_attached :audio
end
