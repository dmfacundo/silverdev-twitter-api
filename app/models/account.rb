class Account < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: true,
    length: { minimum: 5, maximum: 50 },
    format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows letters and numbers" }
end
