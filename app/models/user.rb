class User < ApplicationRecord

  has_many :booklists, dependent: :destroy
  has_many :owned_books, through: :booklists, source: :book

  has_many :booklists, dependent: :destroy
  has_many :required_books, through: :wishlists, source: :book


  before_save { self.email = email.downcase }
  validates :first_name, presence: true,
                         uniqueness: {case_sensitive: false},
                         length: { minimum: 3, maximum: 25 }
 validates :last_name, presence: true,
                        uniqueness: {case_sensitive: false},
                        length: { minimum: 3, maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 105 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
end
