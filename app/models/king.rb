class King < Piece

	def valid_move?(x_destination, y_destination)
		x_distance = (x_coordinates - x_destination).abs
		y_distance = (y_coordinates - y_destination).abs

		valid_destinations = ([0,1],[1,0],[1,1])
		valid_destinations.include?(x_distance) && valid_destinations.include?(y_distance)
	end

end
