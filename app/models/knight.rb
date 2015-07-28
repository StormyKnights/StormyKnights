class Knight < Piece
	def valid_move?(x_destination, y_destination)
		x_distance = (x_coordinates - x_destination).abs
		y_distance = (y_coordinates - y_destination).abs

		(x_distance == 2 && y_distance == 1) || (x_distance == 1 && y_distance == 2)
	end
end
