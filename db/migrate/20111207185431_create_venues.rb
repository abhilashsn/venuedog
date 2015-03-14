class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :website
      t.string :phone_alt
      t.string :description
      t.string :holidays
      t.string :monday
      t.string :tuesday
      t.string :wednesday
      t.string :thursday
      t.string :friday
      t.string :saturday
      t.string :sundays
      t.string :facebook
      t.string :twitter
      t.string :staff_name
      t.string :staff_phone
      t.string :staff_email
      t.string :staff_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end
