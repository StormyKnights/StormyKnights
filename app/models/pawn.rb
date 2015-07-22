class Pawn < Piece

  def valid_move?(x_destination, y_destination)
    if color == 'white'
      if y_coordinates == 1 || y_coordinates == 6           # If Pawn at starting position it can move either 1 or 2 places forward
        x_distance = (x_destination - x_coordinates)
        y_distance = (y_destination - y_coordinates)

        (x_distance == 0 && y_distance == 1) || (x_distance == 0 && y_distance == 2)
      else                                              # If Pawn at any other position other than start it can move 1 place forward
        x_distance = (x_destination - x_coordinates)
        y_distance = (y_destination - y_coordinates)

        (x_distance == 0 && y_distance == 1)
      end
    else color == 'black'
      if y_coordinates == 1 || y_coordinates == 6           # If Pawn at starting position it can move either 1 or 2 places forward
        x_distance = (x_coordinates - x_destination)
        y_distance = (y_coordinates - y_destination)

        (x_distance == 0 && y_distance == 1) || (x_distance == 0 && y_distance == 2)
      else                                              # If Pawn at any other position other than start it can move 1 place forward
        x_distance = (x_coordinates - x_destination)
        y_distance = (y_coordinates - y_destination)

        (x_distance == 0 && y_distance == 1)
      end
    end
  end

  # def valid_move?(x_destination, y_destination)
  #   x_distance = (x_destination - x_coordinates)
  #   y_distance = (y_destination - y_coordinates)
  #
  #   if y_coordinates == 1 || y_coordinates == 6           # If Pawn at starting position it can move either 1 or 2 places forward
  #     x_distance.abs
  #     y_distance.abs
  #
  #     (x_distance == 0 && y_distance == 1) || (x_distance == 0 && y_distance == 2)
  #   else                                              # If Pawn at any other position other than start it can move 1 place forward
  #     x_distance.abs
  #     y_distance.abs
  #
  #     (x_distance == 0 && y_distance == 1)
  #   end
  # end

  # def valid_move?(x_destination, y_destination)
  #   if y_coordinates == 1 || y_coordinates == 6           # If Pawn at starting position it can move either 1 or 2 places forward
  #     x_distance = (x_destination - x_coordinates).abs
  #     y_distance = (y_destination - y_coordinates).abs
  #
  #     (x_distance == 0 && y_distance == 1) || (x_distance == 0 && y_distance == 2)
  #   else                                              # If Pawn at any other position other than start it can move 1 place forward
  #     x_distance = (x_destination - x_coordinates).abs
  #     y_distance = (y_destination - y_coordinates).abs
  #
  #     (x_distance == 0 && y_distance == 1)
  #   end
  # end

end
