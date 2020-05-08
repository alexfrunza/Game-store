module AccountHelper
  def game(game_id)
    Game.find(game_id)
  end

  def games_returned_at_time
    number = Order.where(user_id: current_user.id, returned_at_time: true).count()
    if number == 1
      return "1 game"
    else
      return "#{number} games"
    end
  end
end

