class CreateAdsCities < ActiveRecord::Migration
  def up
    create_table :ads_cities, :id => false do |t|
      t.column :ad_id, :integer
      t.column :city_id, :integer
    end
  end

  def down
  end
end
