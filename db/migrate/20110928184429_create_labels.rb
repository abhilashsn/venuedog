class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.references :event

      t.timestamps
    end
    add_index :labels, :event_id
  end
end
