class Post < ApplicationRecord
  belongs_to :account

  validates :body, presence: true, length: { minimum: 3, maximum: 100 }

  def self.feed(account, page = 1)
    raise ArgumentError, "Page must be a number greater than or equal to 0" if page.to_i < 0
    where(account_id: account.friends.ids)
      .limit(20)
      .offset(20 * (page.to_i - 1))
      .order(created_at: :desc)
  end
end
