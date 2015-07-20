class Piece < ActiveRecord::Base

  belongs_to :game

	  # determines whether the square with coordinates (x, y) is occupied
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
      @slope = (y2 - y1).to_f/(x2 - x1).to_f
    end
  end

  # determines whether the path between piece1 and destination is obstructed by another piece
  def obstructed?(destination)
    # converts the location arrays into easier-to-read x and y terms
    x1 = self.x_coordinates
    y1 = self.y_coordinates
    x2 = destination[0]
    y2 = destination[1]
    # Determines whether the line between piece1 and the destination is horizontal or
    # vertical. If neither, then it calculates the slope of line between piece1 and destination.
    path = check_path(x1, y1, x2, y2)
    # Iterates through every square between piece1 and destination
    # and checks whether it is occupied
    if path == 'horizontal' && x1 < x2
      (x1 + 1).upto(x2 - 1) do |x|
        return true if occupied?(x, y1)
      end
    end
    if path == 'horizontal' && x1 > x2
      (x1 - 1).downto(x2 + 1) do |x|
        return true if occupied?(x, y1)
      end
    end
    if path == 'vertical' && y1 < y2
      (y1 + 1).upto(y2 - 1) do |y|
        return true if occupied?(x1, y)
      end
    end
    if path == 'vertical' && y1 > y2
      (y1 - 1).downto(y2 + 1) do |y|
        return true if occupied?(x1, y)
      end
    end
    if path == 'horizontal' || path == 'vertical'
      return false
    end
    # move diagonally
    if @slope.abs == 1.0 && x1 < x2
      (x1 + 1).upto(x2 - 1) do |x|
        delta_y = x - x1
        y = y2 > y1 ? y1 + delta_y : y1 - delta_y
        return true if occupied?(x, y)
      end
    end
    if @slope.abs == 1.0 && x1 > x2
      (x1 - 1).downto(x2 + 1) do |x|
        delta_y = x1 - x 
        y = y2 > y1 ? y1 + delta_y : y1 - delta_y
        return true if occupied?(x, y)
      end
    end
    if @slope.abs != 1.0
      fail 'path is not a straight line'
    else return false
    end
  end

end
