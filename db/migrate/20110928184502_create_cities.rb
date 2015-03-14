class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :event
      t.string :name
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
    add_index :cities, :event_id
  end
end
