class Piece < ActiveRecord::Base

  belongs_to :game

  validate :valid_move? # call after update_attributes. 
  # create a validation custom method that get trigger when updates_attributes 
 
  def occupied?(x, y)
      self.pieces.where(:x_coordinates => x, :y_coordinates => y).present? 
      # pieces.each do |piece|
      #   return true if piece.x_coordinates == x && piece.y_coordinates == y
      # end
      # false
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



  # determines whether the path between piece1 and destination is obstructed by another piece
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
    # Iterates through every square between piece1 and destination
    # and checks whether it is occupied

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

   def move_to!(new_x, new_y)
    @game = self.game
    if @game.occupied?(new_x, new_y)
      # piece_at_destination = @game.pieces.where(x_coordinates: new_x, y_coordinates: new_y) This does not work.
      # Returns an object of ActiveRecord::AssociationRelation, not a model instance.
      @piece_at_destination = @game.pieces.find_by(x_coordinates: new_x, y_coordinates: new_y)
      if self.color == @piece_at_destination.color
        fail 'destination occupied by piece of same color'
      else
        @piece_at_destination.update_attributes(x_coordinates: nil, y_coordinates: nil)
      end
    end
  end

end
