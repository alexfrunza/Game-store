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

  def order_status_active(game)
    @order = Order.where(game_id: game.id, user_id: current_user.id).last
    if @order
      if @order.status == "active"
        return true
      else
        return false
      end
    else
      return false
    end
  end

end