class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    session[:user_id].present?
  end

  def require_user
    unless logged_in?
      flash[:danger] = 'Please sign in'
      redirect_to root_path
    end
  end
  
end
