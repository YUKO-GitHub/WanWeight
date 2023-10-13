class Dog < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :birthday, presence: true
  validates :sex, inclusion: { in: Dog.sexes.keys }

  enum sex: { unselected: 0, female: 1, male: 2 }

end
