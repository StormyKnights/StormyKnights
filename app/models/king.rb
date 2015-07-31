class King < Piece

	def can_castle?(x_destination, y_destination)
		# king and rook not moved
		# no pieces between king and rook
		# king not in check either at start or at destination
		@has_moved != true && !obstructed?([x_destination, y_destination]) && !@game.in_check?(self.color)
	end

	def castling(x_destination, y_destination)
		@game = self.game
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

	def valid_move?(x_destination, y_destination)
		x_distance = (x_coordinates - x_destination).abs <=1
		y_distance = (y_coordinates - y_destination).abs <=1
		if self.type == 'King' && self.can_castle?(x_destination, y_destination) && x_destination == 7 || x_destination == 1
			return 'castling'
		elsif x_distance && y_distance
			@has_moved = true
			return true
		else
			return false
		end
	end

end
