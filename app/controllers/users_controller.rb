class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  before_action :require_same_user, only: [:edit, :update, :destroy]

  # before_action :require_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the blog #{@user.first_name}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'You account was updated successfully!'
      redirect_to books_path
    else
      render 'edit'
    end
  end

  def show
    # @user.owned_books
    # @user_books = @user.books.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.all
    #paginate(page: params[:page], per_page: 5)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = 'You can only edit your own account'
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = 'Only admin users can perform that action'
      redirect_to root_path
    end
  end

end
