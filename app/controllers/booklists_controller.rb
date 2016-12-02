class BooklistsController < ApplicationController
  before_action :require_user
  def create
    book = Book.find params[:book_id]
    booklist = Booklist.new(user: current_user, book: book)
    if booklist.save
      flash[:success] = 'successfully added to book list!'
    end
    redirect_to book_path(book)
  end

  def destroy
    booklist = Booklist.find params[:id]
    book = booklist.book
    if booklist.destroy
      flash[:success] = 'successfully deleted from book list!'
    end
    redirect_to book_path(book)
  end
end
