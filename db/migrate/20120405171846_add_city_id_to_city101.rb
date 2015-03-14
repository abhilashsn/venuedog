class AddCityIdToCity101 < ActiveRecord::Migration
  def change
    add_column :city101s, :city_id, :integer
  end
end
