# This class contains actions affecting individual pieces.
# Class Piece describes actions relevant to all pieces on the board.
# It is inherited by classes describing different types of pieces.
class Piece < ActiveRecord::Base
  belongs_to :game

  # This method checks whether a piece is present at (x, y).
  #
  # * *Args*    :
  #   - +x, y+ -> x and y coordinates of the instance piece
  # * *Returns* :
  #   - True if square at (x, y) is occupied
  #   - False otherwise
  #
  def occupied?(x, y)
    self.game.pieces.where(x_coordinates: x, y_coordinates: y).present?
  end

  def check_path(x1, y1, x2, y2)
    if y1 == y2
      return 'horizontal'
    elsif x1 == x2
      return 'vertical'
    else
      # move diagonal
      @slope = (y2 - y1).to_f/(x2 - x1).to_f
    end
  end


# This method determines whether the path between instance piece and destination is obstructed by another piece.
#
# * *Args*    :
#   - +destination+ -> array containing x and y coordinates of the piece's intended destination
# * *Returns* :
#   - True if one or more squares between the piece and the destination are occupied
#   - False otherwise
# * *Raises* :
#   - +RuntimeError+ -> if the path is not a straight line
#
  def obstructed?(destination)
    @game = game
    # converts the location arrays into easier-to-read x and y terms
    x1 = self.x_coordinates #assume starting points
    y1 = self.y_coordinates
    x2 = destination[0]
    y2 = destination[1]
    # Determines whether the line between piece1 and the destination is horizontal or
    # vertical. If neither, then it calculates the slope of line between piece1 and destination.
    path = check_path(x1, y1, x2, y2)
    # move horizontal right to left
    if path == 'horizontal' && x1 < x2
      (x1 + 1).upto(x2 - 1) do |x|
        return true if occupied?(x, y1)
      end
    end
    # horizontal left to right
    if path == 'horizontal' && x1 > x2
      (x1 - 1).downto(x2 + 1) do |x|
        return true if occupied?(x, y1)
      end
    end
    # move vertical down
    if path == 'vertical' && y1 < y2
      (y1 + 1).upto(y2 - 1) do |y|
        return true if occupied?(x1, y)
      end
    end
    # move vertical up
    if path == 'vertical' && y1 > y2
      (y1 - 1).downto(y2 + 1) do |y|
        return true if occupied?(x1, y)
      end
    end
    if path == 'horizontal' || path == 'vertical'
      return false
    end
    # move diagonally down
    if @slope.abs == 1.0 && x1 < x2
      (x1 + 1).upto(x2 - 1) do |x|
        delta_y = x - x1
        y = y2 > y1 ? y1 + delta_y : y1 - delta_y
        return true if occupied?(x, y)
      end
    end
    # move diagonally up
    if @slope.abs == 1.0 && x1 > x2
      (x1 - 1).downto(x2 + 1) do |x|
        delta_y = x1 - x
        y = y2 > y1 ? y1 + delta_y : y1 - delta_y
        return true if occupied?(x, y)
      end
    end
    # not a straight diagonal line
    if @slope.abs != 1.0
      fail 'path is not a straight line'
    else return false
    end
  end

  # This method implements capturing a piece.
  #
  # * *Args*    :
  #   - +new_x, new_y+ -> x and y coordinates of the piece's intended destination
  # * *Returns* :
  #   - If intended destination is occupied by piece of the opposite color,
  #     then the occupying piece is removed from the board by setting its coordinates to 'nil'
  #
  # * *Raises* :
  #   - +RuntimeError+ -> if intended destination is occupied by piece of same color
  #
  def move_to!(new_x, new_y)
    @game = self.game
    if occupied?(new_x, new_y)
      @piece_at_destination = @game.pieces.find_by(x_coordinates: new_x, y_coordinates: new_y)
      if self.color == @piece_at_destination.color
        fail 'destination occupied by piece of same color'
      else
        @piece_at_destination.update_attributes(x_coordinates: nil, y_coordinates: nil, status: 'captured')
        @status = @piece_at_destination.status
        @captured = true
      end
    else @captured = false
    end
  end

  def is_castling_to?(x_destination, y_destination)
    false
  end

  def perform_move!(x_destination, y_destination)
    valid_move_result = @piece.valid_move?(x_coordinates, y_coordinates)
    if self.is_castling_to?(x_destination, y_destination)
      self.castling(x_coordinates, y_coordinates)
    elsif valid_move_result
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
    return @valid
  end

  def captured?
    @captured
  end

end
