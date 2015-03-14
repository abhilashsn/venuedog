class AddAdToLandingPageAds < ActiveRecord::Migration
  def change
    add_column :ads, :on_global_homepage, :boolean, :default => false
  end
end
