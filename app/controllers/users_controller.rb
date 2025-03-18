class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = BCrypt::Password.create(params[:password]) # Encrypt password

    if @user.save
      session[:user_id] = @user.id  # Auto-login after signup
      flash[:notice] = "Welcome, #{@user.username}!"
      redirect_to root_path
    else
      flash[:alert] = "Error creating account."
      render :new
    end
  end
end
