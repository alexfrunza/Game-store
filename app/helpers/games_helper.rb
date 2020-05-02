module GamesHelper
  def showGenre(game)
    game.game_types.map(&:name).join(", ")
  end
end