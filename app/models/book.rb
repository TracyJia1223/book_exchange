class Book < ApplicationRecord
  has_many :booklists, dependent: :nullify
  has_many :owners, through: :booklists, source: :user

  has_many :wishlists, dependent: :nullify
  has_many :hunters, through: :wishlists, source: :user

  validates :title, presence: true
  validates :choose_list, presence: true

  def self.own_for(title)
    book_owners = []
    where(title: title).each do |book|
      if book.choose_list=='booklist'
        book.owners.each do |owner|
          book_owners.push(owner)
        end
      end
    end
    return book_owners
  end

  # def wish_for(title)
  #   wishlists.find_by(user: title)
  # end

end
