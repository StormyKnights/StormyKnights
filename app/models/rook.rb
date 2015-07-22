class Rook < Piece
	
	def valid_move? 
		x_coordinates == x_coordinates_was || y_coordinates == y_coordinates_was

		if obstructed?([x_coordinates_was, y_coordinates_was]) # are positions of the x1, and x2
			errors.add(:base, "Move is blocked") # theres some weird with destination so add this error - assigned to object piece
		end
	end

	# def valid_move?(x_destination, y_destination)
 #  	x_coordinates == x_destination || y_coordinates == y_destination
 #  end

	# if obstructed?([x_destination, y_destination])
	# 		errors.add(:base, "Move is blocked")
	# 	else 
			
	

#  end

# 	def obstructed?(x_destination, y_destination)
#    	false
#   end

end