class CreateAdvertisers < ActiveRecord::Migration
  def change
    create_table :advertisers do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :website
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.string :budget_amount
      t.string :period
      t.text :notes

      t.timestamps
    end
  end
end
