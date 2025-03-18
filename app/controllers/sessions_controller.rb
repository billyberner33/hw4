class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email]) # Find user by email

    if @user && BCrypt::Password.new(@user.password) == params[:password] # Decrypt and check
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.username}!"
      redirect_to root_path
    else
      flash[:alert] = "Invalid email or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out."
    redirect_to login_path
  end
end
