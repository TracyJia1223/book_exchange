class User < ApplicationRecord

  has_many :booklists, dependent: :destroy
  has_many :owned_books, through: :booklists, source: :book

  has_many :wishlists, dependent: :destroy
  has_many :wished_books, through: :wishlists, source: :book

  has_many :friendships
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
  acts_as_messageable

  def own_for(user)
    booklists.find_by(user: user)
  end

  def wish_for(user)
    wishlists.find_by(user: user)
  end

  def full_name
    "#{first_name} #{last_name}".strip.squeeze(' ').titleize
  end

  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end

  def except_current_user(users)
    users.reject {|user| user.id == self.id}
  end

  def self.search(param)
    return User.none if param.blank?
    param.strip!
    param.downcase!
    (first_name_matches(param) + last_name_mathches(param) + city_matches(param)).uniq
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_mathches(param)
    matches('last_name', param)
  end

  def self.city_matches(param)
    matches('city', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end

  def name
    "#{first_name}"
  end

  def mailboxer_email(object)
    nil
  end

end
