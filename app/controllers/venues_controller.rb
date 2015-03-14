class VenuesController < ApplicationController

  load_and_authorize_resource

  def index
    @city = City.find(params[:city_id])
    if !params[:venue_category].blank?
      @venues = VenueCategory.find(params[:venue_category]).venues.where('city_id'=>@city.id).real_venues.page(params[:page]).per(6)
    else
      @venues = @city.venues.real_venues.page(params[:page]).per(6)
    end
    add_breadcrumb "Venues", venues_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @venues }
    end
  end


  def show
    @city = City.find(params[:city_id])
    @venue = @city.venues.find(params[:id])
    if !@venue.is_venue
      # render 404
      redirect_to venues_path(@city)
    else
      add_breadcrumb "Venues", venues_path(@city)
      add_breadcrumb @venue.name, venue_path(@city, @venue)

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @venue }
      end
    end
  end





  # GET /venues/new
  # GET /venues/new.json
  def new
    @venue = Venue.new
    @city = City.find(params[:city_id])
    @venue.city = @city
    add_breadcrumb "Venues", venues_path
    add_breadcrumb "New Venue", new_venue_path

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @city = City.find(params[:city_id])
    @venue = Venue.find(params[:id])
  end


  def create
    @city = City.find(params[:city_id])
    @user = current_user
    @venue = Venue.new(params[:venue])
    @venue.city = @city
    @venue.user = @user
    @venue.sanitize_inputs

    respond_to do |format|
      if @venue.save
        format.html { redirect_to venue_success_path(@city, @venue ) }
      else
        format.html { render action: "new" }
      end
    end
  end


  def update
    @city = City.find(params[:city_id])
    @venue = @city.venues.find(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to edit_venue_path(@city, @venue), notice: 'Venue was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @city = City.find(params[:city_id])
    @venue = @city.venues.find(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to :back, :notice => 'Venue removed from VenueDog.' }
      format.json { head :ok }
    end
  end




  # All Events - view all upcoming events at a venue
  # /venues/:id/all-events
  def all_events
    @city = City.find(params[:city_id])
    @venue = Venue.find(params[:id])
    @events = @venue.events.upcoming.page(params[:page]).per(10)
    if !@venue.is_venue
      redirect_to venues_path
    else
      add_breadcrumb "Venues", venues_path
      add_breadcrumb @venue.name, venue_path(@venue)
      add_breadcrumb "All Upcoming Events", nil

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @venue }
      end
    end
  end


  # Venue created success page
  def success
    @city = City.find(params[:city_id])
    @venue = @city.venues.find(params[:id])
    add_breadcrumb "New Venue", new_venue_path
  end

end
