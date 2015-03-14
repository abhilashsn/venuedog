class AddCityIdToFrontpageSliders < ActiveRecord::Migration
  def change
    add_column :frontpage_sliders, :city_id, :integer
  end
end
