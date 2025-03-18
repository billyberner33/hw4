class EntriesController < ApplicationController
  before_action :require_login
  before_action :set_place, only: [:new, :create, :index]

  def index
    @entries = @place.entries.where(user: current_user)
  end

  def new
    @place = Place.find(params[:place_id])
    @entry = @place.entries.build
  end
  
  def create
    @place = Place.find(params[:place_id])
    @entry = @place.entries.build(entry_params.merge(user: current_user)) 
  
    if @entry.save
      flash[:notice] = "Entry created successfully!"
      redirect_to place_path(@place)
    else 
      flash[:alert] = "Something went wrong."
      render :new
    end 
  end  

  private

  def set_place
    @place = Place.find(params[:place_id])  # Find the place from the nested route
  end

  def entry_params
    params.require(:entry).permit(:title, :description, :occurred_on, :uploaded_image)
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to perform this action."
      redirect_to login_path
    end
  end
end
