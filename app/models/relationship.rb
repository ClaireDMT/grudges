class Relationship < ApplicationRecord
  belongs_to :invitor, class_name: 'User'
  belongs_to :invitee, class_name: 'User'
  validates :invitee, uniqueness: { scope: :invitor }

  RELATIONS = %w[partner roomate colleague].freeze
end
