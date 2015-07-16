class King < Piece

	def valid_move?(x_destination, y_destination)
		x_distance = (x_coordinates - x_destination).abs <=1
		y_distance = (y_coordinates - y_destination).abs <=1

		x_distance && y_distance
	end

end
