class GamesController < ApplicationController
  def home
    @games = Game.all
  end

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    @genre_list = params[:genre_list]
  end

  def create
    @game = Game.new(game_params)
    @game.stock = 0
    binding.pry
    @game.save
  end

  private
    def game_params
      params.require(:game).permit(:title, :about, :release_date, :developer_id, :franchise_id, :platform_id)
    end
end
