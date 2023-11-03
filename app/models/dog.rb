class Dog < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  enum sex: { unselected: 0, female: 1, male: 2 }

  validates :name, presence: true
  validates :birthday, presence: true
  validates :sex, inclusion: { in: Dog.sexes.keys }
end
