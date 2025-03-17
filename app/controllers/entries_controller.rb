class EntriesController < ApplicationController
  before_action :require_login

  def index
    @entries = current_user.entries  # Only fetch entries for the logged-in user
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build(entry_params)  # Assigns entry to logged-in user
    if @entry.save
      flash[:notice] = "Entry created successfully!"
      redirect_to place_path(@entry.place_id)  # Redirect to the specific place's page
    else 
      flash[:alert] = "Something went wrong."
      render :new
    end 
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :uploaded_image, :place_id)
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to perform this action."
      redirect_to login_path
    end
  end
end
