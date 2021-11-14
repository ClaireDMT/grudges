class UserGrudge < ApplicationRecord
  belongs_to :guilty, class_name: 'User'
  belongs_to :offended, class_name: 'User'
  belongs_to :grudge

  scope :with_partner, -> { where(guilty: current_user.partner) }

end
