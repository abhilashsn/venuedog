class AddHomepageBoolToAds < ActiveRecord::Migration
  def change
    add_column :ads, :on_homepage, :boolean
  end
end
