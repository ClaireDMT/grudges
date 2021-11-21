module Relation
  extend ActiveSupport::Concern

  included do
    has_many  :relationships

    has_many  :pending_invited, -> { where('relationships.pending': true) }, :through => :friendships, :source => :friend
    has_many  :invited, -> { where(:'friendships.pending' => false, :'friendships.blocker_id' => nil) }, :through => :friendships, :source => :friend
  end

  # suggest a user to become a friend. If the operation succeeds, the method returns true, else false
  def invite(user)
    return false if user == self || find_any_friendship_with(user)
    Amistad.friendship_class.new{ |f| f.friendable = self ; f.friend = user }.save
  end

  # approve a friendship invitation. If the operation succeeds, the method returns true, else false
  def approve(user)
    friendship = find_any_friendship_with(user)
    return false if friendship.nil? || invited?(user)
    friendship.update_attribute(:pending, false)
  end


    # returns the list of approved friends
  def friends
    friendship_model = Amistad::Friendships.const_get(:"#{Amistad.friendship_model}")

    approved_friendship = friendship_model.where(friendable_id: id, pending: false, blocker_id: nil).select(:friend_id).to_sql
    approved_inverse_friendship = friendship_model.where(friend_id: id, pending: false, blocker_id: nil).select(:friendable_id).to_sql

    self.class.where("id in (#{approved_friendship}) OR id in (#{approved_inverse_friendship})")
  end

  # total # of invited and invited_by without association loading
  def total_friends
    self.invited(false).count + self.invited_by(false).count
  end

  # checks if a user is a friend
  def friend_with?(user)
    friends.include?(user)
  end

  # checks if a current user is connected to given user
  def connected_with?(user)
    find_any_friendship_with(user).present?
  end

  # checks if a current user received invitation from given user
  def invited_by?(user)
    friendship = find_any_friendship_with(user)
    return false if friendship.nil?
    friendship.friendable_id == user.id
  end

  # checks if a current user invited given user
  def invited?(user)
    friendship = find_any_friendship_with(user)
    return false if friendship.nil?
    friendship.friend_id == user.id
  end

  # returns friendship with given user or nil
  def find_any_friendship_with(user)
    friendship = Amistad.friendship_class.where(:friendable_id => self.id, :friend_id => user.id).first
    if friendship.nil?
      friendship = Amistad.friendship_class.where(:friendable_id => user.id, :friend_id => self.id).first
    end
    friendship
  end
end
