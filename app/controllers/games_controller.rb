class GamesController < ApplicationController

  def home
    @games = Game.all
  end

  def index
    @games = Game.all
  end

  def show
    @game = Game.find_by(title: params[:id])
    if @game == nil
      @game = Game.find(params[:id])
    end
    # @genre = @game.game_types.map(&:name).join(", ")
  end

  def new
    verify_user
    @game = Game.new
    @genre_list = params[:genre_list]

  end

  def create
    verify_user
    @game = Game.new(game_params)
    if @game.valid?
      @game.save
      redirect_to 'games/new'
    else
      render 'games/new'
    end

  end

  private

    def game_params
      params.require(:game).permit(:title, :about, :release_date, :developer_id, :franchise_id, :rarity_id, :platform_id,:stock , game_type_ids:[])
    end

    def verify_user
      if user_signed_in?
        if !current_user.admin?
          redirect_to '/'
        end
      else
        redirect_to '/'
      end

    end

end
