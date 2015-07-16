class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(white_user_id: 1, black_user_id:2)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def update
  end

  # def game_params
  #   params.require(:game).permit(
  #     :white_user_id,
  #     :black_user_id)
  # end
end
