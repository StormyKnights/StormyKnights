class PiecesController < ApplicationController

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    x_coordinates = params[:x_coordinates].to_i
    y_coordinates = params[:y_coordinates].to_i
    @piece.perform_move!(x_coordinates, y_coordinates)
    if @piece.promote
      @captured_pieces = Piece.where(game: @game, color: @piece.color, type: ["Rook", "Bishop", "Knight", "Queen"], status: 'captured')
    end

    # if @piece.type == 'Pawn' && (y_coordinates == 7 || y_coordinates == 0)
    #   @piece.promote(y_coordinates, choice)
    # end

    respond_to do |format|
      format.html do
        redirect_to game_path(@game)  # redirect to game show page
      end
      format.json do
        json_result = { 
          valid: @piece.valid, 
          captured: @piece.captured, 
          castle: @piece.castle, 
          promote: @piece.promote, 
          promote_form: if @piece.promote
            render_to_string(template: 'games/promote_form.html.erb', layout: false)
          else
            ""
          end,
          status: @piece.status 
        }
        render json: json_result
      end
    end

  end

  def promote
    @piece_to_be_promoted = Piece.find(params[:piece_id])
    @piece_to_promote_to = Piece.find(params[:choice])
    
    if @piece_to_promote_to.status == "captured"
      @piece_to_promote_to.update_attributes(x_coordinates: @piece_to_be_promoted.x_coordinates, y_coordinates: @piece_to_be_promoted.y_coordinates, status: nil)
      @piece_to_be_promoted.update_attributes(x_coordinates: nil, y_coordinates: nil, status: 'promoted')
    end

    redirect_to game_path(@piece_to_promote_to.game)
  end

  def show
    @piece = Piece.find(params[:id])
    @pieces = @piece.game.pieces # display all the pieces on the board
  end

  private

  def piece_params
    params.require(:piece).permit(:x_coordinates, :y_coordinates)
  end
end
