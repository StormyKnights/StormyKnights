class PiecesController < ApplicationController
  
  def create
  	@piece = Piece.new # set new piece?
  end

  def update
  	@piece = Piece.find(params[:id])
  	@piece.update_attributes(piece_params) #correct?
  	redirect_to game_path(@piece.game)  #
  	
  end

  def show
	  @piece = Piece.find(params[:id])
    @pieces = @piece.game.pieces 
 
  end

  private

  def piece_params
  	params.require(:piece).require(:x_coordinates, :y_coordinates)
  end

end
