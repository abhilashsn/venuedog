require 'spec_helper'
  describe Venuedog::API do
   describe "GET /woof/events" do
     it "returns an empty array of statuses" do
       get "/api/v1/statuses"
         response.status.should == 200
          JSON.parse(response.body).should == []
       end
     end
  end
