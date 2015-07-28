class PiecesController < ApplicationController


  def update
		@piece = Piece.find(params[:id]) 
		@game = @piece.game

    
    if @piece.update_attributes(x_coordinates: params[:x_coordinates], y_coordinates: params[:y_coordinates]) #move the pieces by passing in x,y coordinates
  	   flash[:notice] = "Move made"  # no errors move successful
     else
        flash[:alert] = 'Move is invalid'
     end

    respond_to do |format|
      format.html do 
        redirect_to game_path(@game)  #redirect to game show page
      end
      format.json do
        render json: params
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
