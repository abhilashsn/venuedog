class ShareEventMailer < ActionMailer::Base
  include MailersHelper
  helper :mailers
  default from: "dog@venuedog.com"

  #ActionMailer::Base.raise_delivery_errors = true
  #ActionMailer::Base.delivery_method = :sendmail
  #ActionMailer::Base.sendmail_settings = {
  #  :location => '/usr/sbin/sendmail',
  #  :arguments => '-i -t'
  #}



  def share_event_email(your_name, email, event)
    @your_name = your_name
    @event = event
    mail(:to => email, :subject => "#{your_name} and VenueDog Want You to Know About #{event.name}!")
  end

end
