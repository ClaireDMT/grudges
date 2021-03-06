class User < ApplicationRecord
  include Relation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_grudges
  has_many :grudges, through: :user_grudges
  has_one_attached :photo
  validates :username, uniqueness: true

  def partnership
    relationships.find(relation: 'partner')
  end

  def partner
    partnership.user1 == current_user ? partnership.user2 : partnership.user1
  end
end
