class Bishop < Piece

  def valid_move?(x_destination, y_destination)
    
    (x_coordinates - x_destination).abs == (y_coordinates - y_destination).abs 
  end
 
  def obstructed?()

  end 
end