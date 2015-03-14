class Attachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :venue
      t.string :attachment_file_name
      t.string :attachment_file_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at
      t.timestamps
    end
  end

end
