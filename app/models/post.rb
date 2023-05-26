class Post < ApplicationRecord
  belongs_to :account

  validates :body, presence: true, length: { minimum: 3, maximum: 100 }
end
