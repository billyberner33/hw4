class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"] })
  end

  def new
  end

  def create
    if User.find_by({ "id" => session["user_id"]})
      @place = Place.new
      @place["name"] = params["name"]
      @place.save

      flash["notice"] = "Place was successfully created"
      redirect_to "/places"
    else
      flash["notice"] = "You have to be logged in"
      redirect_to "/places"
    end
  end
end
