class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title
      t.text :about
      t.integer :stock
      t.string :release_date
      t.references :developer, null: false, foreign_key: true
      t.references :game_type, null: false, foreign_key: true
      t.references :franchise, null: true, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
