class Relationship < ApplicationRecord
  belongs_to :user1,  class_name: 'User'
  belongs_to :user2,  class_name: 'User'
  validates :user1, uniqueness: { scope: :user2 }

  RELATIONS = %w[partner roomate colleague].freeze
end
