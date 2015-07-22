class Bishop < Piece
	
	def valid_move?
		if (x_position - x_destination_was).abs != (y_position - y_destination_was).abs
			errors.add(:base, "Move is no diagonal")
		end
		if obstructed?([x_postion_was, y_position_was]) # are position the x1, and x2
			errors.add(:base, "Move is blocked") # theres some weird with destination so add this error - assigned to object piece
		end
	end


# 	def valid_move?(x_destination, y_destination)
#    (x_coordinates - x_destination).abs == (y_coordinates - y_destination).abs)
# 	end

		# def obstructed?(x_destination, y_destination)

		# end
end