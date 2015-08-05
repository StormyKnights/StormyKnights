class PiecesController < ApplicationController

  def update
		@piece = Piece.find(params[:id])
		@game = @piece.game
    x_coordinates = params[:x_coordinates].to_i
    y_coordinates = params[:y_coordinates].to_i
    valid_move_result = @piece.valid_move?(x_coordinates, y_coordinates)
    if valid_move_result == 'castling'
      @piece.castling(x_coordinates, y_coordinates)
    elsif valid_move_result == true
      @piece.move_to!(x_coordinates, y_coordinates)
      if @piece.update_attributes(x_coordinates: params[:x_coordinates], y_coordinates: params[:y_coordinates]) #move the pieces by passing in x,y coordinates
    	   # flash[:notice] = "Move made"  # no errors move successful
         @valid = true
         @captured = @piece.captured?
      end
    else
      # flash[:alert] = 'Move is invalid'
      @valid = false
    end

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
