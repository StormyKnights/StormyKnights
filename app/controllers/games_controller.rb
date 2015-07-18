class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = @game.pieces
  end

  def update
  end

  private

  def game_params
    params.fetch(:game).permit(
      :white_user_id,
      :black_user_id)
  end
end
