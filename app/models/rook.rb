class Rook < Piece

	def valid_move?(x_destination, y_destination)
		if (x_coordinates == x_destination || y_coordinates == y_destination) &&
  		!obstructed?([x_destination, y_destination])
				@has_moved = true
				return true
		end
	end

end
