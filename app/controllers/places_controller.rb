class PlacesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by(id: params[:id])
    if @place
      @entries = @place.entries.where(user_id: session[:user_id]) if @place.respond_to?(:entries)
    else
      flash[:alert] = "Place not found."
      redirect_to places_path
    end
  end

  def new
    @place = Place.new
  end

  def create
    if session[:user_id] # Ensure user is logged in
      @place = Place.new(name: params[:name]) # Use params[:name] directly
      if @place.save
        flash[:notice] = "Place was successfully created."
        redirect_to places_path
      else
        flash[:alert] = "Error creating place."
        render :new
      end
    else
      flash[:alert] = "You must be logged in to create a place."
      redirect_to login_path
    end
  end
  
  private

  def place_params
    params.require(:place).permit(:name)
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to perform this action."
      redirect_to login_path
    end
  end
end
