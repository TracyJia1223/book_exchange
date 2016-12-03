class BooksController < ApplicationController
  # BOOKS_PER_PAGE = 5
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
    @book_owners = Book.own_for(@book.title)
    # @ownership = Booklist.search_for_user(@book, current_user)

    # @comment = Comment.new
    # @like = @book.like_for(current_user)
  end

  def index
    # if params[:search]
    #   @books = Book.search(params[:search]).order(created_at: :desc)
    #   # .paginate(page: params[:page], per_page: BOOKS_PER_PAGE)
    # else
      @books = Book.order(created_at: :desc)
      # .paginate(page: params[:page], per_page: BOOKS_PER_PAGE)
      # .page(params[:page]).per(BOOKS_PER_PAGE)
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


  def add_to_wishlist
    add_to_wish_list
    redirect_to user_path(current_user)
  end

  def add_to_booklist
    add_to_book_list
    redirect_to user_path(current_user)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :weight, :description, :image, :choose_list)
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def add_to_book_list
    Booklist.create(book: @book, user: current_user)
    flash[:success] = 'book was successfully added to your Book List!'
  end

  def add_to_wish_list
    Wishlist.create(book: @book, user: current_user)
    flash[:success] = 'book was successfully added to your Wish List!'
  end

  def require_same_user
    if current_user != @book.user
      flash[:danger] = 'You can only edit or delete your own books'
      redirect_to root_path
    end
  end
end
