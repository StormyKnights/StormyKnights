class PiecesController < ApplicationController

  def update
		@piece = Piece.find(params[:id])
		@game = @piece.game
    x_coordinates = params[:x_coordinates].to_i
    y_coordinates = params[:y_coordinates].to_i
    @piece.perform_move!(x_destination, y_destination)
    
    respond_to do |format|
      format.html do
        redirect_to game_path(@game)  #redirect to game show page
      end
      format.json do
        json_result = {:valid => @valid, :captured => @captured, :status => @status}
        render json: json_result
      end
    end

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
