class HomeController < ApplicationController
  def index
    @recent_games = Game.all.order(created_at: :desc).limit(3)
  end
end
