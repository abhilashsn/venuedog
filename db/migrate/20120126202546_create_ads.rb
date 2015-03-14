class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.references :advertiser
      t.string :name
      t.datetime :start
      t.datetime :end
      t.string :size
      t.string :destination
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_uploaded_at
      t.text :notes
      t.references :category
      t.string :locations

      t.timestamps
    end
    add_index :ads, :advertiser_id
    add_index :ads, :category_id
  end
end
