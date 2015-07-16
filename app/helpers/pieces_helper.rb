module PiecesHelper
	def piece_class(selected_piece, current_piece)
		if selected_piece == current_piece
			return "selected_piece img-responsive"
		else
			return "img-responsive"
		end
	end
end
