class SystemEmail < ActionMailer::Base
  #default from: "system@saidigital.co"
  default from: "dog@venuedog.com"


  # Emails from 'Contact-Us' page
  def contact_page_notification(contact)
    logger.debug(contact.inspect) #contact = params[:contact]
    @contact_info = contact
    mail(:to => "info@venuedog.com", :subject => "New Contact Form Submission")
  end


end
