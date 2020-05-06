module GamesHelper
  def showGenre(game)
    game.game_types.map(&:name).join(", ")
  end

  def platforms
    Platform.all.map(&:name)
  end

  def game_types
    GameType.all.map(&:name)
  end

  def developers
    Developer.all.map(&:name)
  end

  def franchises
    Franchise.all.map(&:name)
  end

  def rarities
    Rarity.all.map(&:name)
  end
end