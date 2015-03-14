class AdvertiseWithUsMailer < ActionMailer::Base
 include MailersHelper
 helper :mailers
 #default from: "system@saidigital.co"
  default from: "dog@venuedog.com"


  # Emails from 'Contact-Us' page
  def advertise_contact_form(name,email,phone,company,city)
    @name = name
    @email = email
    @phone = phone
    @company = company
    @city = city
    mail(:to => "info@venuedog.com", :subject => "#{name} @ #{company} filled out a new 'Advertise With Us' Form!")
  end


end
