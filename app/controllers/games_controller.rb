class GamesController < ApplicationController
  before_action :set_game, only: [:show, :destroy, :edit, :update]
  before_action :require_admin, only: [:new, :create, :destroy, :edit, :update]

  def index
    @games = Game.all
    if params["search"]
      @filter = params["search"]["platform"]
                    .concat(params["search"]["game_type"])
                    .concat(params["search"]["developer"])
                    .concat(params["search"]["franchise"])
                    .concat(params["search"]["rarity"])
                    .flatten.reject(&:blank?)
      @filter.each do |filter|
        @games = @games.tagged_with(filter, any: true)
      end
    else
      @games = Game.all
    end
  end

  def show
  end

  def new
    @game = Game.new
    @genre_list = params[:genre_list]
  end

  def edit
  end

  def update
    if @game.update(game_params)
      add_tags
      make_url_for_youtube
      @game.save
      redirect_to "/games/#{@game.id}"
    else
      render "/games/#{@game.id}/edit"
    end
  end

  def create
    @game = Game.new(game_params)
    if @game.valid?
      add_tags
      make_url_for_youtube
      @game.save
      redirect_to admin_games_path
    else
      render admin_games_path
    end
  end

  def destroy
    @game.destroy
    redirect_to admin_games_path
  end

  private
  def make_url_for_youtube
    @game.video_url = "https://www.youtube.com/embed/" + @game.video_url
  end

  def game_params
    params.require(:game).permit(:title, :about, :release_date, :developer_id,
                                 :franchise_id, :rarity_id, :platform_id,
                                 :stock, :photo_url, :video_url, game_type_ids:[])
  end

  def require_admin
    unless user_signed_in? and current_user.admin?
      redirect_to root_path
    end
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def add_tags
    @game.tag_list = nil
    tags = []
    tags.push(@game.developer.name)
    tags.push(@game.rarity.name)
    tags.push(@game.franchise.name)
    tags.push(@game.platform.name)

    game_types = @game.game_types.map(&:name)
    game_types.each do |game_type|
      tags.push(game_type)
    end

    tags.each do |tag|
      @game.tag_list.add(tag)
    end

  end

end
