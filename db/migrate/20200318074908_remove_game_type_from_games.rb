class RemoveGameTypeFromGames < ActiveRecord::Migration[6.0]
  def change
    remove_reference :games, :game_type, null: false, foreign_key: true
  end
end
