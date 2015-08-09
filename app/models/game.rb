# This class contains actions that affect the overall state of the game.
class Game < ActiveRecord::Base

  has_many :users
  has_many :pieces

  belongs_to :white_user, class_name: 'User', foreign_key: 'white_user_id'
  belongs_to :black_user, class_name: 'User', foreign_key: 'black_user_id'

  after_create :populate_board!

  # This method populates the board with pieces after a new game is created.
  #
  # * *Args*    : none
  # * *Returns* : chess pieces assigned to starting locations on the board
  #
  def populate_board!

    # Populate Pawns
    (0..7).each do |x|
      Pawn.create(x_coordinates: x, y_coordinates: 1, game_id: self.id, color: 'white', image: 'white-pawn.png', status: 'active') # White
      Pawn.create(x_coordinates: x, y_coordinates: 6, game_id: self.id, color: 'black', image: 'blk-pawn.png', status: 'active') # Black
    end

    # Populate Rook
    Rook.create(x_coordinates: 0, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-rook.png', status: 'active') # White
    Rook.create(x_coordinates: 7, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-rook.png', status: 'active') # White
    Rook.create(x_coordinates: 0, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-rook.png', status: 'active') # Black
    Rook.create(x_coordinates: 7, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-rook.png', status: 'active') # Black

    # Populate Knight
    Knight.create(x_coordinates: 1, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-knight.png', status: 'active' ) # White
    Knight.create(x_coordinates: 6, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-knight.png', status: 'active' ) # White
    Knight.create(x_coordinates: 1, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-knight.png', status: 'active' ) # Black
    Knight.create(x_coordinates: 6, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-knight.png', status: 'active' ) # Black

    # Populate Bishop
    Bishop.create(x_coordinates: 2, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-bishop.png', status: 'active') # White
    Bishop.create(x_coordinates: 5, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-bishop.png', status: 'active') # White
    Bishop.create(x_coordinates: 2, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-bishop.png', status: 'active') # Black
    Bishop.create(x_coordinates: 5, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-bishop.png', status: 'active') # Black

    # Populate Queen
    Queen.create(x_coordinates: 3, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-queen.png', status: 'active') # White
    Queen.create(x_coordinates: 3, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-queen.png', status: 'active') # Black

    # Populate King
    King.create(x_coordinates: 4, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-king.png', status: 'active') # White
    King.create(x_coordinates: 4, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-king.png', status: 'active') # Black
  end

  # This method determines whether player of a given color is in a state of check.
  #
  # * *Args*    :
  #   - +current_color+ -> string indicating the color of the player in question
  # * *Returns* :
  #   - True if current_color player is in check
  #   - False otherwise
  #
  def in_check?(current_color)
    check = []
    king = pieces.find_by(type: 'King', color: current_color)
    opponent_pieces = pieces.where.not(color: current_color)

    opponent_pieces.each do |opponent_piece|
      if  opponent_piece.type != "King" && opponent_piece.status == 'active'
        if opponent_piece.valid_move?(king.x_coordinates, king.y_coordinates)
          check << opponent_piece
        end
      # A new valid_move method for king (king_valid_move_for_in_check?) is used in this iteration
      # in order to prevent executing can_castle?, which would lead
      # to executing obstructed?, which would throw a runtime error
      # when checking the path between two opposite kings
      elsif opponent_piece.type == "King"
         if opponent_piece.king_valid_move_for_in_check?(king.x_coordinates, king.y_coordinates)
           check << opponent_piece
         end
      end # End opponent_piece valid_move! check
    end # End opponent_pieces block for determining if game is in_check

    # If check variable has more than 0 items the game is in check otherwise is not in check
    if check.count > 0
      true
    else
      false
    end

  end # End in_check? method

end
