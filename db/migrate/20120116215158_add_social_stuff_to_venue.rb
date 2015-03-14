class AddSocialStuffToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :yelp, :string
    add_column :venues, :foursquare, :string
  end
end
