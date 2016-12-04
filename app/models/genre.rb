class Genre < ApplicationRecord
  has_many :book_genres, dependent: :nullify
  has_many :books, through: :book_genres, source: :book

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }

  validates_uniqueness_of :name
end
