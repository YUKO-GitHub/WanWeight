class Dog < ApplicationRecord
  belongs_to :user
  has_many :dog_weights, dependent: :destroy
  has_one_attached :avatar

  enum sex: { unselected: 0, female: 1, male: 2 }

  validates :name, presence: true
  validates :birthday, presence: true
  validates :sex, inclusion: { in: Dog.sexes.keys }
  validates :avatar, content_type: {
                       in: ['image/png', 'image/jpg', 'image/jpeg'],
                       message: 'はPNG、JPG、JPEG形式でアップロードしてください',
                     },
                     size: {
                       less_than: 5.megabytes,
                       message: 'のサイズは5MB以下にしてください',
                     }
end
