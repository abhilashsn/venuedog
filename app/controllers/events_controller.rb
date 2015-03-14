class EventsController < ApplicationController

  load_and_authorize_resource


  # Events Index and Weekly Events Pagination
  def index
    @city = City.find( params[:city_id] )

    if params.has_key?('start_at')
      d = params[:start_at].to_date
      @started_at = d
      @events = @current_city.events.in_range(d, (d + 6)).approved
      wk_start = @started_at.to_datetime
      wk_end = wk_start + 7
      add_breadcrumb wk_start.strftime("%b %e") + " - " + wk_end.strftime("%b %e") , ""
    else
      @started_at = Date.current
      @events = @city.events.upcoming.approved.where("`start_time` <= ?", (@started_at + 7).to_s(:db) )
    end


    add_breadcrumb "Events", events_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @events }
    end
  end




  def show
    @city = City.find(params[:city_id])
    @event = @city.events.find(params[:id])
    add_breadcrumb "Events", events_path
    add_breadcrumb @event.start_time.strftime("%b. %e, %Y"), "/show-by-date/" + @event.start_time.strftime("%Y-%m-%d")
    add_breadcrumb @event.name, event_path(@event)

    respond_to do |format|
      format.html # show.html.erb
      format.ics do
          headers['Content-Type'] = "text/calendar; charset=UTF-8"
          render :text => @event.to_ical()
      end
      format.json { render :json => @event }
    end
  end


  # Events shown by date
  def show_by_date
    @city = City.find(params[:city_id])
    @events = @city.events.show_by_date(params[:date])
    d = Date.parse(params[:date])
    @started_at = d
    @date = d

    add_breadcrumb @city.name, city_path( @city )
    add_breadcrumb d.strftime("%b. %e, %Y"), "/show-by-date/" + d.strftime("%Y-%m-%d")
  end



  # Search results for entire site
  def search
    @city = City.find(params[:city_id])
    @events = @city.events.search(params[:search])
    @categories = Category.search(params[:search])
    @venues = @city.venues.search(params[:search])
    add_breadcrumb "Events", events_path( @city )
    add_breadcrumb "Search", ''
  end



  def new
    @city = City.find(params[:city_id])
    @event = Event.new
    @event.city = @city

    @venues = Venue.all
    @venue = Venue.new
    @venue.city = @city
    @labels = Label.all
    @categories = Category.all
    @root_categories = Category.roots
    @venue_location = Venue.new
    @venue_location.city = @city
    add_breadcrumb "Events", events_path(@city)
    add_breadcrumb "Add an event", new_event_path(@city)

    respond_to do |format|
      format.html
    end
  end



  def edit
    @city = City.find(params[:city_id])
    @event = Event.find(params[:id])
    @venue = @event.venue
    @labels = Label.all
    @categories = Category.all
    @root_categories = Category.roots
    add_breadcrumb "Events", events_path
    add_breadcrumb @event.name, event_path(@event)
  end




  def create
    @user = current_user
    @city = City.find(params[:city_id])
    @event = Event.new(params[:event])
    @event.city = @city
    @event.user = @user


    # Determine New/Existing Venue, add attributes for validation
    if @event.venue_id.blank?
      @venue = Venue.new(params[:event][:venue_attributes])
      @venue.description = "Venue for " + @event.name + " Event"
      @venue.city = @city
      if @venue.save
        @event.venue_id = @venue.id
      end
    end

    # Require Event Category
    if @event.category_ids.blank?
      redirect_to new_event_path(@city), :notice => 'Please select an event category.'
    else
      # Add posted start and end dates-times
      format_start = "%m/%d/%Y"
      format_start << " %l:%M %p" if !params[:event][:start_time_clock].blank?
      format_end = "%m/%d/%Y" if !params[:event][:end_time_date].blank?
      format_end << " %l:%M %p" if !params[:event][:end_time_clock].blank?
      @event.approved = true
      @event.start_time = DateTime.strptime(params[:event][:start_time_date] + ' ' + params[:event][:start_time_clock], format_start)
      if !params[:event][:end_time_date].blank?
        @event.end_time = DateTime.strptime(params[:event][:end_time_date] + ' ' + params[:event][:end_time_clock], format_end)
      end
  
      @event.sanitize_inputs
  
      respond_to do |format|
        if @event.save
          format.html { redirect_to event_success_path( @city, @event ) }
        else
          format.html { render :action => "new" }
        end
      end

    end

  end


  # Route for user after events successfully created
  def success
    @city = City.find(params[:city_id])
    @event = Event.find(params[:id])
    if @event.created_at < Time.now - 1.hour
      redirect_to event_path( @city, @event )
    else
      add_breadcrumb "New Event", new_event_path( @city )
      add_breadcrumb @event.name, event_path( @city, @event )
    end
  end





  # Update Event and Associated Venue
  def update
    @event = Event.find(params[:id])
    @city = City.find(params[:city_id])
    params[:event][:label_ids] ||= []
    params[:event][:category_ids] ||= []

    # Determine if choosing existing venue.is_venue or adding/updating location
    # WARNING VENUE is only validated on create in model
    if params[:event][:venue_id].blank? 
      if !params[:event][:venue_attributes].blank?
          # New Fake Venue
          if params[:event][:venue_attributes][:venue_id].blank?
            @delta_venue = params[:event][:venue_attributes]
            @delta_venue.delete("venue_id")
            @venue = Venue.new(@delta_venue)
            @venue.description = "Venue for " + @event.name + " Event"
            if @venue.save
              @event.venue = @venue
            else  
              redirect_to :back, :notice => 'Please select an existing venue or add an event location.'
            end

          # Save potential changes to old fake venue
          else
            @venue = Venue.find(params[:event][:venue_attributes][:venue_id])
            @delta_venue = params[:event][:venue_attributes]
            @delta_venue.delete("venue_id")
            @venue.update_attributes(@delta_venue) if !@venue.is_venue?
            @event.venue = @venue
          end
      end
    else
      @event.venue = Venue.find(params[:event][:venue_id])
    end


    # Add posted start and end dates-times
    format_start = "%m/%d/%Y"
    format_start << " %l:%M %p" if !params[:event][:start_time_clock].blank?
    format_end = "%m/%d/%Y" if !params[:event][:end_time_date].blank?
    format_end << " %l:%M %p" if !params[:event][:end_time_clock].blank?
    @event.approved = true
    @event.start_time = DateTime.strptime(params[:event][:start_time_date] + ' ' + params[:event][:start_time_clock], format_start)
    if !params[:event][:end_time_date].blank?
      @event.end_time = DateTime.strptime(params[:event][:end_time_date] + ' ' + params[:event][:end_time_clock], format_end)
    end

    @event.sanitize_inputs

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to edit_event_path(@event.city, @event), :notice => 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @event.errors, :status => :unprocessable_entity }
      end
    end
  end





  def destroy
    @city = City.find(params[:city_id])
    @event = @city.events.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to :back, :notice => 'Event removed from VenueDog.' }
      format.json { head :ok }
    end
  end


  def share_event_email

    email = params[:email_share_event][:email]
    your_name = params[:email_share_event][:your_name]
    event = Event.find(params[:email_share_event][:event_id])
    email.split(',').each do |e|
      ShareEventMailer.share_event_email(your_name,e,event).deliver
    end
    respond_to do |format|
      format.html {redirect_to event, :notice => "Thank you for sharing this event!"}
    end
  end





  # JSON for Event calendar widget color scheme
  def events_per_day
    city = City.find(params[:city_id])
    @events = city.events.month(params[:year], params[:month])
    days = {}
    (1..31).each do |d|
      days[d] = 0
    end

    @events.each do |e|
      days[e.start_time.day] += 1
    end

    respond_to do |format|
      format.json { render :json => days}
    end
  end





end
