class Queen < Piece

def valid_move?
    # from rook 
    if (x_position - x_destination_was).abs != (y_position - y_destination_was).abs || 
    	(x_position != x_position_was && y_position != y_position_was)
			errors.add(:base, "Move is no diagonal or perpendicular") 
		end

		if obstructed?([x_postion_was, y_position_was]) # are position the x1, and x2
			errors.add(:base, "Move is invalid") # theres some weird with destination so add this error - assigned to object piece
		end
	end

   # def valid_move?(x_destination, y_destination)
   #  #  x_coordinates == x_destination || y_coordinates == y_destination
   #  # || ((x_coordinates - x_destination).abs == (y_coordinates - y_destination).abs)
   # end

end
