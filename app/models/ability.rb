class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    if true
    #user.role? :super_admin
      can :manage, :all
      can :access, :rails_admin

    elsif user.role? :venuedog_user
      can :read, :all

      can :manage, CalendarEvent do |c|
        c.try(:owner) == user
      end

      can :manage, Event do |e|
        e.try(:owner) == user
      end

      can :manage, Venue do |v|
        v.try(:owner) == user
      end

      can :manage, User do |u|
        u.try(:owner) == user
      end

      can :create, CalendarEvent
      can :create, Event
      can :create, Venue

      can :all_events, Event
      can :share_event_email, Event
      can :events_per_day, Event
      can :homepage, Page

      can :users_events, CalendarEvent, :id => user.id
      can :users_calendar, CalendarEvent, :id => user.id
      can :users_profile, CalendarEvent, :id => user.id
      can :success, Event


      can :contact_us, Page
      can :email_contact, Page
      can :advertise_with_us, Page
      can :advertise_with_us_contact_form, Page
      can :faqs, Page
      can :privacy_policy, Page

      can :show_by_date, Event
      can :search, Event
      can :events_per_day, Event
      can :all_events, Venue

      can :robots, Page

    else
      can :read, :all
      can :all_events, Event
      can :share_event_email, Event
      can :events_per_day, Event
      can :homepage, Page

      can :contact_us, Page
      can :email_contact, Page
      can :advertise_with_us, Page
      can :advertise_with_us_contact_form, Page
      can :faqs, Page
      can :privacy_policy, Page

      can :create, User


      can :show_by_date, Event
      can :search, Event
      can :events_per_day, Event
      can :all_events, Venue

      can :robots, Page

      # Multicity
      can :show, City
      can :index, Event
      can :show, Event


    end
  end
end
