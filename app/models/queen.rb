class Queen < Piece
    def valid_move?(x_destination, y_destination)
      ((x_coordinates == x_destination || y_coordinates == y_destination) || 
      ((x_coordinates - x_destination).abs == (y_coordinates - y_destination).abs)) &&
      !obstructed?([x_destination, y_destination])
    end
end

