class Dog < ApplicationRecord
  belongs_to :user
  has_many :dog_weights, dependent: :destroy
  has_one_attached :avatar

  enum sex: { unselected: 0, female: 1, male: 2 }

  validates :name, presence: true, length: { maximum: 10 }
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
  validate :dog_limit, on: :create

  def dog_limit
    if user && user.dogs.count >= 3
      errors.add(:user, "は3匹までの愛犬しか登録できません")
    end
  end

  def latest_weight
    dog_weights.order(date: :desc).first
  end

  def weights_for_month(start_date, end_date)
    dog_weights.where(date: start_date.beginning_of_day..end_date.end_of_day).
      map { |weight| [weight.date.to_date, weight.weight] }.to_h
  end
end
