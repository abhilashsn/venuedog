class ReminderMailer < ActionMailer::Base

  include MailersHelper
  helper :mailers
  default from: "dog@venuedog.com"


  def reminder(your_name, email,event)
    @your_name = your_name
    @event = Event.find(event)
    if !@event.blank?
      mail(:to => email, :subject => "VenueDog Event Reminder: #{@event.name} @ #{@event.start_time.strftime("%b. %e, %Y, at %l:%M %P")}!")
    end
  end
end
