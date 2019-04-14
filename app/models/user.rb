class User < ApplicationRecord
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  has_many :articles, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

  before_save { self.email = email.downcase }
end
