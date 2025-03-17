class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :current_user, :logged_in?

  def set_current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user
    @current_user
  end

  def logged_in?
    !!@current_user
  end
end
