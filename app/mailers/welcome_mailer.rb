class WelcomeMailer < ActionMailer::Base
  default from: "dog@venuedog.com"

  def send_message(email)
     mail(:to => email, :subject => "Welcome to VenueDog!")
  end

end

