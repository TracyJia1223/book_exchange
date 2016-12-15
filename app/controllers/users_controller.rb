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
      flash[:success] = "Welcome to the Bookshelf #{@user.first_name}"
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
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @user_wished_books = @user.wished_books.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
    @user_owned_books = @user.owned_books.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
  end

  def index
    @users = User.order(created_at: :desc).paginate(page: params[:page], per_page: 3)
  end

  def my_friends
    @friendships = current_user.friends
  end

  def search
    @users = User.search(params[:search_param])
    if @users
      @users = current_user.except_current_user(@users)
      render partial: "friends/lookup"
    else
      render status: :not_found, nothing: true
    end
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      flash[:success] = 'Friend was successfully added'
      redirect_to my_friends_path
    else
      flash[:danger] = "There was an error with adding user as a friend"
      redirect_to my_friends_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :city, :zip_code, :email, :password, :image)
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
