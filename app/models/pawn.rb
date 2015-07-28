class Pawn < Piece

  def valid_move?(x_destination, y_destination)
    if occupied?(x_destination, y_destination)
      x_distance = (x_destination - x_coordinates)
      y_distance = (y_destination - y_coordinates)
      if color == 'white'
        x_distance.abs == 1 && y_distance == 1
      elsif color == 'black'
        x_distance.abs == 1 && y_distance == -1
      end
    elsif color == 'white'
      if y_coordinates == 1 || y_coordinates == 6           # If Pawn at starting position it can move either 1 or 2 places forward
        x_distance = (x_destination - x_coordinates)
        y_distance = (y_destination - y_coordinates)

        (x_distance == 0 && y_distance == 1) || (x_distance == 0 && y_distance == 2)  && !obstructed?([x_destination, y_destination])
      else                                              # If Pawn at any other position other than start it can move 1 place forward
        x_distance = (x_destination - x_coordinates)
        y_distance = (y_destination - y_coordinates)

        (x_distance == 0 && y_distance == 1) && !obstructed?([x_destination, y_destination])
      end
    elsif color == 'black'
      if y_coordinates == 1 || y_coordinates == 6           # If Pawn at starting position it can move either 1 or 2 places forward
        x_distance = (x_coordinates - x_destination)
        y_distance = (y_coordinates - y_destination)

        (x_distance == 0 && y_distance == 1) || (x_distance == 0 && y_distance == 2) && !obstructed?([x_destination, y_destination])
      else                                              # If Pawn at any other position other than start it can move 1 place forward
        x_distance = (x_coordinates - x_destination)
        y_distance = (y_coordinates - y_destination)

        (x_distance == 0 && y_distance == 1) && !obstructed?([x_destination, y_destination])
      end
    end
  end

end
