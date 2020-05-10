class GamesController < ApplicationController
  before_action :set_game, only: [:show, :destroy, :edit, :update, :borrow_game, :return_game]
  before_action :require_admin, only: [:new, :create, :destroy, :edit, :update]
  before_action :verify_num_borrowed_games, only: [:borrow_game]
  before_action :verify_stock, only: [:borrow_game]

  def index
    @games = Game.all

    @search = params["search_bar"]
    if @search.present?
      @title = @search["title"]
      @games = Game.where("title ILIKE ?", "%#{@title}%")
    end

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
      redirect_to game_path(:id => @game.id)
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
    Order.where(game_id: @game.id).map(&:destroy)
    @game.destroy
    redirect_to admin_games_path
  end

  def borrow_game
    if user_signed_in?
      @order = Order.new
      @order.game_id = @game.id
      @order.user_id = current_user.id
      @order.status = "active"
      @order.return_time = Time.now + 5.minutes
      @game.stock -= 1
      current_user.borrowed_games += 1
      current_user.save
      @game.save
      @order.save
    end
    redirect_to game_path(:id => @game.id)
  end

  def return_game
    if user_signed_in?
      @order = Order.where(game_id: @game.id, user_id: current_user.id).last
      if @order
        @order.returned_time = Time.now
        if @order.returned_time <= @order.return_time
          @order.returned_at_time = true
        end
        @order.status = "completed"
        @game.stock += 1
        current_user.borrowed_games -= 1
        current_user.save
        @game.save
        @order.save
      end
    end
    redirect_to game_path(:id => @game.id)
  end

  private
  def verify_stock
    if @game.stock == 0
      redirect_to game_path(:id => @game.id)
    end
  end

  def verify_num_borrowed_games
    if current_user.borrowed_games >= 3
      redirect_to game_path(:id => @game.id)
    end
  end

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
