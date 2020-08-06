class User < ApplicationRecord
  acts_as_token_authenticatable

  validates :first_name, presence: true
  validates :last_name, presence: true
end
