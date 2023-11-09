class DogWeight < ApplicationRecord
  belongs_to :dog

  validates :weight, presence: true, numericality: { less_than_or_equal_to: 150 }
  validates :date, presence: true
end
