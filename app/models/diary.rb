class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :dog, optional: true
  has_many_attached :photos

  validate :photos_count_within_limit

  private

  def photos_count_within_limit
    if photos.length > 4
      errors.add(:photos, 'は最大4枚までです。')
    end
  end
end
