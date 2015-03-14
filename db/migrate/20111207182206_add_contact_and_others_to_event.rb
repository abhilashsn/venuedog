class AddContactAndOthersToEvent < ActiveRecord::Migration
  def change
    add_column :events, :website, :string
    add_column :events, :event_host, :string
    add_column :events, :event_contact, :string
  end
end
