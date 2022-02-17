class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :username, uniqueness: true, presence: true
  validates_presence_of :password, require: true

  has_secure_password
end
