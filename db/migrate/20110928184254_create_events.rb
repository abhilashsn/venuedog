class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :all_day

      t.timestamps
    end
    add_index :events, :user_id
  end
end
