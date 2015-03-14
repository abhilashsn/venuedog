class RenameLabelsEventsToEventsLabels < ActiveRecord::Migration
  def change
    rename_table :labels_events, :events_labels
  end

end
