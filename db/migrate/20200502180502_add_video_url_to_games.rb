class AddVideoUrlToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :video_url, :string
  end
end
