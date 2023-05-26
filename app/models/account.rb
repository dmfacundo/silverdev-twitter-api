class Account < ApplicationRecord
  has_and_belongs_to_many :friends,
    class_name: "Account",
    join_table: "accounts_friends",
    foreign_key: "account_id",
    association_foreign_key: "friend_id"

  validates :name,
    presence: true,
    uniqueness: true,
    length: { minimum: 5, maximum: 50 },
    format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows letters and numbers" }

  def follow(account)
    errors.add(:friends, "You are already following this account") if friends.include?(account)
    errors.add(:friends, "You can't follow yourself") if account == self
    return false if errors.any?
    friends << account
  end
end
