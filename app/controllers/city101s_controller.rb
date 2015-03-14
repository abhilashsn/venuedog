class City101sController < ApplicationController
  load_and_authorize_resource

  # GET /city101s/1
  # GET /city101s/1.json
  def show
    @city = City.find(params[:city_id])
    @city101 = @city.city101
    @ads = @city.ads.city101_125x125

    add_breadcrumb "City 101", city_101_path(@city)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @city101 }
    end
  end

end
