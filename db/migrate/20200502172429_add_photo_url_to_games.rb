class AddPhotoUrlToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :photo_url, :string
  end
end
