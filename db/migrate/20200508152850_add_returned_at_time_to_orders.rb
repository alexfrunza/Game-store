class AddReturnedAtTimeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :returned_at_time, :boolean, :default => false
  end
end
