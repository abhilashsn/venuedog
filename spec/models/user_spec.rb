require 'spec_helper'

def valid_user_attributes

  { 
    :email => "sean+12312venuedog@saidigital.co",
    :password => "abcdefg",
    :password_confirmation => "abcdefg"

    }
end


describe User do
  describe "A user (in general)" do
    before(:each) do
      @user = User.new
    end

    it "should be invalid without an email address" do
      @user.attributes = valid_user_attributes.except(:email)
      @user.should_not be_valid
      @user.should have(1).error_on(:email)
      @user.errors.get(:email).should include "can't be blank"
      @user.email = "sean+venuedogtestering@saidigital.co"
      @user.should be_valid
    end
  end
end
