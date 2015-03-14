class LabelsHaveAndBelongToManyEvents < ActiveRecord::Migration
  def up
    create_table :labels_events, :id => false do |t|
      t.references :label, :event
    end
  end

  def down
    drop_table :labels_events
  end
end

