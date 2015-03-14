class RemoveEventIdFromLabels < ActiveRecord::Migration
  def up
    remove_column :labels, :event_id
    add_column :labels, :name, :string
  end

  def down
    add_column :labels, :event, :string
    remove_column :labels, :name
  end
end
