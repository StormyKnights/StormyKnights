class King < Piece

  def can_castle?(x_destination, y_destination)
    # Castling allowed if:
    # king and rook not moved
    # no pieces between king and rook
    # king not in check either at start or at destination
    @game = game
    @has_moved != true && !obstructed?([x_destination, y_destination]) && @game.in_check?(color) == false
  end

  def castling(x_destination)
    @game = game
    if x_destination == 7
      self.update_attributes(x_coordinates: 6)
      kingside_rook = @game.pieces.find_by(x_coordinates: 7, type: "Rook", color: self.color)
      kingside_rook.update_attributes(x_coordinates: 5)
    elsif x_destination == 0
      self.update_attributes(x_coordinates: 2)
      queenside_rook = @game.pieces.find_by(x_coordinates: 0, type: "Rook", color: self.color)
      queenside_rook.update_attributes(x_coordinates: 3)
    end
  end

  def castling_to?(x_destination, y_destination)
    can_castle?(x_destination, y_destination) && x_destination == 7 || x_destination == 0
  end

  def valid_move?(x_destination, y_destination)
    x_distance = (x_coordinates - x_destination).abs <= 1
    y_distance = (y_coordinates - y_destination).abs <= 1
    if castling_to?(x_destination, y_destination)
      return true
    elsif x_distance && y_distance
      @has_moved = true
      return true
    else
      return false
    end
  end

  def king_valid_move_for_in_check?(x_destination, y_destination)
    x_distance = (x_coordinates - x_destination).abs <=1
    y_distance = (y_coordinates - y_destination).abs <=1
    x_distance && y_distance
  end

end
