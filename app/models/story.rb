class Story < ApplicationRecord
  has_one_attached :video
  validates_presence_of :video
end
