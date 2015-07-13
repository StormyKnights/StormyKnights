class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def update
  end

  def game_params
    params.permit(:game).permit(
      :white_user_id,
      :black_user_id)
  end
end
