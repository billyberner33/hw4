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
      reset_session  # Logs the user out
      redirect_to root_path, notice: "Logged out successfully!"
    end
  end
