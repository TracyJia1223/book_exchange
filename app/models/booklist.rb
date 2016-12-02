class Booklist < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book_id, presence: true, uniqueness: {scope: :user_id}
  validates :user_id, presence: true

  def self.search_for_user(book, user)
    list = Booklist.where(book: book, user: user)
    if list.nil?
      return false
    else
      return true
    end
  end
end
