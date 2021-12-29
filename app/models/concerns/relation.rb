module Relation
  extend ActiveSupport::Concern

  included do
    has_many  :relationships

    has_many  :pending_invited, -> { where('relationships.pending': true) }
    has_many  :invited, -> { where('relationships.pending': false) }
  end

  # suggest a user to become a friend. If the operation succeeds, the method returns true, else false
  def invite(user)
    return false if user == self || find_any_relationship_with(user)

    Relationship.create(invitor: self, invitee: user)
  end

  # approve a friendship invitation. If the operation succeeds, the method returns true, else false
  def approve(user)
    relationship = find_any_relationship_with(user)
    return false if relationship.nil? || invited?(user)

    relationship.update_attribute(:pending, false)
  end

  #   # returns the list of approved friends
  def relations
    as_invitee = Relationship.where(invitee: self, pending: false).pluck(:invitor_id)
    as_invitor = Relationship.where(invitor: self, pending: false).pluck(:invitee_id)

    User.where(id: as_invitee + as_invitor)
  end

  # # total # of invited and invited_by without association loading
  # def total_friends
  #   self.invited(false).count + self.invited_by(false).count
  # end

  # # checks if a user is a friend
  # def friend_with?(user)
  #   friends.include?(user)
  # end

  # # checks if a current user is connected to given user
  # def connected_with?(user)
  #   find_any_friendship_with(user).present?
  # end

  # # checks if a current user received invitation from given user
  # def invited_by?(user)
  #   friendship = find_any_friendship_with(user)
  #   return false if friendship.nil?
  #   friendship.friendable_id == user.id
  # end

  # checks if a current user invited given user
  def invited?(user)
    relationship = find_any_relationship_with(user)
    return false if relationship.nil?

    relationship.invitee == user
  end

  def invited_by?(user)
    relationship = find_any_relationship_with(user)
    return false if relationship.nil?

    relationship.invitor == user
  end

  # # returns friendship with given user or nil
  def find_any_relationship_with(user)
    Relationship.find_by(invitee: self, invitor: user) || Relationship.find_by(invitee: user, invitor: self)
  end
end
