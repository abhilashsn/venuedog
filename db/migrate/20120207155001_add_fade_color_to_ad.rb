class AddFadeColorToAd < ActiveRecord::Migration
  def change
    add_column :ads, :background_color, :string
  end
end
