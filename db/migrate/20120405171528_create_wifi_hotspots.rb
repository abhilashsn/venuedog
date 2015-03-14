class CreateWifiHotspots < ActiveRecord::Migration
  def change
    create_table :wifi_hotspots do |t|
      t.string :name
      t.string :address
      t.string :longitude
      t.string :latitude
      t.references :city

      t.timestamps
    end
    add_index :wifi_hotspots, :city_id
  end
end
