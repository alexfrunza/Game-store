class AddBorrowedGamesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :borrowed_games, :integer, :default => 0
  end
end
