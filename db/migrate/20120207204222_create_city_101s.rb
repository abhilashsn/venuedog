class CreateCity101s < ActiveRecord::Migration
  def change
    create_table :city_101s do |t|
      t.string :city
      t.string :zip
      t.text :description
      t.text :links

      t.timestamps
    end
  end
end
