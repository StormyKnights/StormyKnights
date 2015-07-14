class Game < ActiveRecord::Base

  has_many :users
  has_many :pieces

  belongs_to :white_user, class_name: 'User', foreign_key: 'white_user_id'
  belongs_to :black_user, class_name: 'User', foreign_key: 'black_user_id'

  after_create :populate_board!

  def populate_board!

    # Populate Pawns
    (0..7).each do |x|
      Pawn.create(x_coordinates: x, y_coordinates: 1, game_id: self.id, color: 'white', image: 'white-pawn.png') # White
      Pawn.create(x_coordinates: x, y_coordinates: 6, game_id: self.id, color: 'black', image: 'blk-pawn.png') # Black
    end

    # Populate Rook
      Rook.create(x_coordinates: 0, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-rook.png') # White
      Rook.create(x_coordinates: 7, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-rook.png') # White
      Rook.create(x_coordinates: 0, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-rook.png') # Black
      Rook.create(x_coordinates: 7, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-rook.png') # Black

    # Populate KnightsKnight
      Knight.create(x_coordinates: 1, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-knight.png' ) # White
      Knight.create(x_coordinates: 6, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-knight.png' ) # White
      Knight.create(x_coordinates: 1, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-knight.png' ) # Black
      Knight.create(x_coordinates: 6, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-knight.png' ) # Black

    # Populate Bishop
      Bishop.create(x_coordinates: 2, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-bishop.png') # White
      Bishop.create(x_coordinates: 5, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-bishop.png') # White
      Bishop.create(x_coordinates: 2, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-bishop.png') # Black
      Bishop.create(x_coordinates: 5, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-bishop.png') # Black

    # Populate Queen
      Queen.create(x_coordinates: 3, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-queen.png') # White
      Queen.create(x_coordinates: 3, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-queen.png') # Black

    # Populate King
      King.create(x_coordinates: 4, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-king.png') # White
      King.create(x_coordinates: 4, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-king.png') # Black

  end

  #determines whether the square with coordinates (x, y) is occupied
  def is_occupied?(x, y) 
    pieces.each do |piece|
      if piece.x_coordinates == x && piece.y_coordinates == y
        return true
      end
    end
    return false
  end

  #determines whether the path between piece1 and destination is obstructed by another piece
  def is_obstructed?(piece1_loc, destination)
    #converts the location arrays into easier-to-read x and y terms
    x1 = piece1_loc[0]
    y1 = piece1_loc[1]
    x2 = destination[0]
    y2 = destination[1]
    
    # Determines whether the line between piece1 and the destination is horizontal or
    # vertical. If neither, then it calculates the slope of line between piece1 and destination.
    if y1 == y2
      horizontal = true
    elsif x1 == x2
      vertical = true
    else
      slope = (y2-y1).to_f/(x2-x1).to_f
    end

    # iterates through every square between piece1 and destination
    # and checks whether it is occupied
    if horizontal && x1 < x2
      (x1+1..x2-1).each do |x|
        return true if is_occupied?(x, y1)
      end
    end
    if horizontal && x1 > x2
      (x2+1..x1-1).each do |x|
        return true if is_occupied?(x, y1)
      end
    end
    if vertical && y1 < y2
      i = y1+1
      while i < y2 do
        return true if is_occupied?(x1, i)
        i += 1
      end
    end
    if vertical && y1 > y2
      (y2+1..y1-1).each do |y|
        return true if is_occupied?(x1, y)
      end
    end
    if horizontal || vertical
      return false
    end
    if slope.abs == 1.0 && x1 < x2
      (x1+1..x2-1).each do |x|
        delta_y = x-x1
        y = y2 > y1 ? y1 + delta_y : y1 - delta_y
        return true if is_occupied?(x, y)
      end
    end
    if slope.abs == 1.0 && x1 > x2
      (x2+1..x1-1).each do |x|
        delta_y = x1-x
        y = y2 > y1 ? y1 + delta_y : y1 - delta_y
        return true if is_occupied?(x, y)
      end
    end
    if (slope.abs != 1.0)
      fail 'path is not a straight line'
    else return false
    end
  end


end
