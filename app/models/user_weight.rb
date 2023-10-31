class UserWeight < ApplicationRecord
  belongs_to :user

  validates :weight, presence: true, numericality: { less_than_or_equal_to: 200 }
  validates :date, presence: true
end
