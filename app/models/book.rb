class Book < ApplicationRecord
  has_many :booklists, dependent: :destroy
  has_many :owners, through: :booklists, source: :user

  has_many :wishlists, dependent: :destroy
  has_many :hunters, through: :wishlists, source: :user
end
