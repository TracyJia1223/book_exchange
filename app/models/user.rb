class User < ApplicationRecord

  has_many :booklists, dependent: :destroy
  has_many :owned_books, through: :booklists, source: :book

  has_many :wishlists, dependent: :destroy
  has_many :wished_books, through: :wishlists, source: :book

  has_many :firendships
  has_many :friends, through: :friendships


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
  mount_uploader :image, ImageUploader

  def own_for(user)
    booklists.find_by(user: user)
  end

  def wish_for(user)
    wishlists.find_by(user: user)
  end

  def full_name
    "#{first_name} #{last_name}".strip.squeeze(' ').titleize
  end

end
