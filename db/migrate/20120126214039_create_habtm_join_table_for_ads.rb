class CreateHabtmJoinTableForAds < ActiveRecord::Migration
  def up

    create_table :ads_categories, :id => false do |t|
      t.references :ad, :null => false
      t.references :category, :null => false
    end
    add_index( :ads_categories, [:ad_id, :category_id], :unique => true)

  end

  def down
    drop_table :ads_categories
  end
end
