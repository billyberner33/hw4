class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id  # Log in the user after signup
      flash[:notice] = "Account created successfully! Welcome, #{@user.username}."
      redirect_to places_path
    else
      flash[:alert] = "Something went wrong. Please check your inputs."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
