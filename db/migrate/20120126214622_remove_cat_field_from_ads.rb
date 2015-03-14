class RemoveCatFieldFromAds < ActiveRecord::Migration
  def up
    remove_column :ads, :category_id
  end

  def down
  end
end
