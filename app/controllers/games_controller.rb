class GamesController < ApplicationController
  def home
    @games = Game.all
  end

  def index
    @games = Game.all
  end

  def new
    verify_user
    @game = Game.new
    @genre_list = params[:genre_list]
  end

  def create
    verify_user
    @game = Game.new(game_params)
    @game.stock = 0
    @game.save
  end

  private

    def game_params
      params.require(:game).permit(:title, :about, :release_date, :developer_id, :franchise_id, :platform_id)
    end

    def verify_user
      unless current_user.admin?
        redirect_to root_path, :alert => "Acces denied."
      end
    end

end
