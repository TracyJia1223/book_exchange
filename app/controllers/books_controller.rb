class BooksController < ApplicationController
  before_action :find_book, only: [:edit, :update, :destroy, :show, :add_to_booklist, :add_to_wishlist]
  before_action :require_user, except: [:index, :show]
  # before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    list = params[:book][:choose_list]
    if @book.save
      @user = current_user
      if list == 'wishlist'
        add_to_wish_list
      elsif list == 'booklist'
        add_to_book_list
      end
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def show
    @book_owners = Book.own_for(@book.title, current_user)
  end

  def index
    @books = Book.order(created_at: :desc).limit(5)
  end

  def edit
  end

  def update
    if @book.update book_params
      flash[:success] = 'Book was successfully updated!'
      redirect_to book_path(@book)
    else
      # flash.now[:alert] = 'Please see the errors below'
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:danger] = 'Book was successfully deleted!'
    redirect_to user_path(current_user)
  end

  def my_search
    # @books = Book.all
  end

  def search
    @books = Book.search(params[:search_param])
    if @books
      render partial: "lookup"
    else
      render status: :not_found, nothing: true
    end

  end


  def add_to_wishlist
    Wishlist.create(book: @book, user: current_user)
    flash[:success] = 'book was successfully added to your Wish List!'
    redirect_to user_path(current_user)
  end

  def add_to_booklist
    Booklist.create(book: @book, user: current_user)
    flash[:success] = 'book was successfully added to your Book List!'
    redirect_to(user_path(current_user))
    #{user_path(current_user)}"
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :weight, :description, :image, :choose_list, :unit, genre_ids: [])
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def require_same_user
    if current_user != @book.user
      flash[:danger] = 'You can only edit or delete your own books'
      redirect_to root_path
    end
  end
end
