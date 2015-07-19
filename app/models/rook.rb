class Rook < Piece
	
  def valid_move?(x_destination, y_destination)
    x_coordinates == x_destination || y_coordinates == y_destination

  end

  def obstructed?(x_destination, y_destination)
    false
  end

end