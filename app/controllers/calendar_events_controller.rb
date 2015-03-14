class CalendarEventsController < ApplicationController
#  include MailJob

  load_and_authorize_resource


  # User's created events
  def users_events
    @user = current_user
    @events = current_user.events.upcoming.uniq
    @past_events = current_user.events.upcoming.uniq
    @city = @user.city
    add_breadcrumb "Profile", "/profile"
    add_breadcrumb "My Events", '/profile/my-event-listings'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @calendars }
    end
  end

  def reminder
    cal = CalendarEvent.find(params[:id])

    if !cal.blank? and cal.has_reminder.blank?
      #mailreminder = ReminderJob.new(cal.id,cal.event.start_time)
      #mailreminder.remind

      #Subtract 29 hours from start time to move the start_date to eastern time.
      #Not good, but it works for now. Please fix this in the future.
      Delayed::Job.enqueue(MailJob.new(cal.id,cal.event.start_time), 0, cal.event.start_time.getutc - 24.hours)
      cal.has_reminder = true
      cal.save
    else
      cal.has_reminder = !cal.has_reminder
      cal.save
    end

    redirect_to request.referer
  end


  # User's calendar
  def users_calendar
    @user = current_user
    # NEEDS to be sorted by calendar_event.event.start_time but view needs calendar events
    @calendar_events = @user.upcoming_calendar_events
    @past_calendar_events = @user.past_calendar_events
    @city = @user.city

    add_breadcrumb "Profile", "/profile"
    add_breadcrumb "My Calendar", '/profile/my-calendar'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @calendars }
    end
  end


  # User's Profile, "/profile"
  def users_profile

    @user = current_user
    @calendar_events = @user.upcoming_calendar_events[0...4]
    @events = @user.events[0...4]
    @city = @user.city
    add_breadcrumb "Profile", "/profile"

    respond_to do |format|
      format.html # index.html.erb
    end
  end



  def new
    @calendar = CalendarEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @calendar }
    end
  end

  def edit
    @calendar = CalendarEvent.find(params[:id])
  end

  def create
    @event = Event.find(params[:event_id])
    @calendar = CalendarEvent.new(:event_id => @event.id)
    @calendar[:user_id] = current_user.id
    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, :notice => 'Calendar was successfully created.' }
        format.js
        format.json { render :json => @calendar, :status => :created, :location => @calendar }
      else
        format.html { render :action => "new" }
        format.json { render :json => @calendar.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @calendar = CalendarEvent.find(params[:id])

    respond_to do |format|
      if @calendar.update_attributes(params[:calendar])
        format.html { redirect_to @calendar, :notice => 'Calendar was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @calendar.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @calendar = CalendarEvent.find(params[:id])
    @calendar.destroy

    respond_to do |format|
      format.html { redirect_to :back, :notice => 'Event removed from your calendar.' }
      format.json { head :ok }
    end
  end
end
