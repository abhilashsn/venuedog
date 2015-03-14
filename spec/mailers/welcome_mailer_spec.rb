require "spec_helper"

@test_email = "sean+venuedogtesting@saidigital.co"

describe WelcomeMailer do
  describe "welcome message" do
    it "should render successfully" do
      lambda { WelcomeMailer.send_message(@test_email) }.should_not raise_error
    end

     describe "rendered without error" do

       before(:each) do
         @user = Factory.build(:user)
         @user = Factory.create(:user)
         @user = Factory(:user)
         @mailer = WelcomeMailer.send_message(@user.email)
       end

      it "should deliver successfully" do
        lambda { @mailer.deliver }.should_not raise_error
      end

        describe "and delivered" do

          it "should be added to the delivery queue" do
            lambda { @mailer.deliver }.should change(ActionMailer::Base.deliveries,:size).by(1)
          end

        end

     end

  end
end
