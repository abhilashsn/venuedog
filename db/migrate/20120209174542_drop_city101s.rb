class DropCity101s < ActiveRecord::Migration
  def up
    drop_table :city_101s
  end

  def down
      create_table :city_101s do |t|
        t.string :city
        t.string :zip
        t.text :description
        t.text :links

      t.timestamps
    end
  end
end
