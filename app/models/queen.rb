class Queen < Piece

  def valid_move?(x_destination, y_destination)
    straight = (x_coordinates == x_destination) || (y_coordinates == y_destination)
    diagonal = ((x_coordinates - x_destination).abs == (y_coordinates - y_destination).abs)

    straight || diagonal
  end
end
