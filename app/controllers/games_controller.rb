class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
      @open_games = Game.where(black_user_id: nil).where.not(white_user_id: current_user.id).first(10)
    end
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(white_user_id: current_user.id)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
    @black_player = User.find_by(id: @game.black_user_id)
    @white_player = User.find_by(id: @game.white_user_id)
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(black_user_id: current_user.id)
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:white_user_id, :black_user_id)
  end
end
