class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
  end

  def show
    @piece = Piece.all
  end

  def update
  end

end