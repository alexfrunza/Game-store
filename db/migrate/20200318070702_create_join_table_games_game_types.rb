class CreateJoinTableGamesGameTypes < ActiveRecord::Migration[6.0]
  def change
    create_join_table :games, :game_types do |t|
      t.index [:game_id, :game_type_id]
      t.index [:game_type_id, :game_id]
    end
  end
end
