class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :dog, optional: true
  has_many_attached :photos

  validates :diary_text, length: { maximum: 1000 }, allow_blank: true
  validates :meal_text, length: { maximum: 1000 }, allow_blank: true
  validates :exercise_text, length: { maximum: 1000 }, allow_blank: true
  validates :health_text, length: { maximum: 1000 }, allow_blank: true

  validate :photos_count_within_limit
  validate :photos_format_and_size

  private

  def photos_count_within_limit
    if photos.length > 4
      errors.add(:photos, 'は最大4枚までです。')
    end
  end

  def photos_format_and_size
    photos.each do |photo|
      if !photo.content_type.in?(%w(image/png image/jpg image/jpeg))
        errors.add(:photos, 'はPNG、JPG、JPEG形式でアップロードしてください')
      elsif photo.blob.byte_size > 5.megabytes
        errors.add(:photos, 'のサイズは5MB以下にしてください')
      end
    end
  end
end
