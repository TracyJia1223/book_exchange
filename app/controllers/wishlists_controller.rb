class WishlistsController < ApplicationController
  before_action :require_user
  def create
    book = Book.find params[:book_id]
    wishlist = Wishlist.new(user: current_user, book: book)
    if wishlist.save
      flash[:success] = 'successfully added to book list!'
    end
    redirect_to book_path(book)
  end

  def destroy
    wishlist = Wishlist.find params[:id]
    book = wishlist.book
    if wishlist.destroy
      flash[:success] = 'successfully deleted from book list!'
    end
    redirect_to book_path(book)
  end
end
