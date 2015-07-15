class PiecesController < ApplicationController

  def update
		@piece = Piece.find(params[:id]) 
		@game = @piece.game
  	@piece.update_attributes(piece_params) #correct?
  	redirect_to game_path(@piece.game)  
  end

  def show
	  @piece = Piece.find(params[:id])
    @pieces = @piece.game.pieces #display all the pieces on the board 
 
  end

  private

  def piece_params
  	params.require(:piece).permit(:x_coordinates, :y_coordinates)
   end

end
