class AddRarityToGames < ActiveRecord::Migration[6.0]
  def change
    add_reference :games, :rarity, null: false, foreign_key: true
  end
end
