class Book < ApplicationRecord
  has_many :booklists, dependent: :nullify
  has_many :owners, through: :booklists, source: :user

  has_many :wishlists, dependent: :nullify
  has_many :hunters, through: :wishlists, source: :user

  has_many :book_genres, dependent: :nullify
  has_many :genres, through: :book_genres, source: :genre

  validates :title, presence: true
  validates :choose_list, presence: true

  mount_uploader :image, ImageUploader

  def self.own_for(title, current_user)
    book_owners = []
    where(title: title).each do |book|
      if book.choose_list=='booklist'
        book.owners.each do |owner|
          if (owner.id != current_user.id)
            book_owners.push(owner)
          end
        end
      end
    end
    return book_owners
  end

  def self.search(param)
    return Book.none if param.blank?
    param.strip!
    param.downcase!
    (title_matches(param) + author_mathches(param) + publisher_matches(param)).uniq
  end

  def self.title_matches(param)
    matches('title', param)
  end

  def self.author_mathches(param)
    matches('author', param)
  end

  def self.publisher_matches(param)
    matches('publisher', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end

end
