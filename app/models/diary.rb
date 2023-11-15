class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :dog, optional: true
end
