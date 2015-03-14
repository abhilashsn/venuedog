class AddBuyTicketToEvents < ActiveRecord::Migration
  def change
    add_column :events, :buy_tickets, :string
  end
end
