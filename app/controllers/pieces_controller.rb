class PiecesController < ApplicationController

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    @color = @piece.color

    x_coordinates = params[:x_coordinates].to_i
    y_coordinates = params[:y_coordinates].to_i

    Piece.transaction do
      @piece.perform_move!(x_coordinates, y_coordinates)
      if @game.in_check?(@color)
        raise ActiveRecord::Rollback
      end
    end


    respond_to do |format|
      format.html do
        redirect_to game_path(@game)  # redirect to game show page
      end
      format.json do
        json_result = { valid: @piece.valid, captured: @piece.captured, castle: @piece.castle, status: @piece.status, moved_into_check: @piece.moved_into_check, not_color: @piece.not_color }
        render json: json_result
      end
    end

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
