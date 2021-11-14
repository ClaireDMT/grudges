class Grudge < ApplicationRecord
  CATEGORIES = ["sex", "family", "food", "chores", "hygiene" ].freeze
  has_many :user_grudges
  has_many :users, through: :user_grudges


end
