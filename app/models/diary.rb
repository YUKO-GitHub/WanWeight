class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :dog, optional: true
  has_many_attached :photos
end
