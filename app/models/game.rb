class Game < ActiveRecord::Base

  has_many :users
  has_many :pieces

  belongs_to :white_user, :class_name => "User", :foreign_key => "white_user_id"
  belongs_to :black_user, :class_name => "User", :foreign_key => "black_user_id"

  after_create :populate_board!

  def populate_board!

    # Populate Pawns
    (0..7).each do |x|
      Piece.create(name: 'Pawn', x_coordinates: x, y_coordinates: 1, game_id: self.id) # White
      Piece.create(name: 'Pawn', x_coordinates: x, y_coordinates: 6, game_id: self.id) # Black
    end

    # Populate Rook
      Piece.create(name: 'Rook', x_coordinates: 0, y_coordinates: 0, game_id: self.id) # White
      Piece.create(name: 'Rook', x_coordinates: 7, y_coordinates: 0, game_id: self.id) # White
      Piece.create(name: 'Rook', x_coordinates: 0, y_coordinates: 7, game_id: self.id) # Black
      Piece.create(name: 'Rook', x_coordinates: 7, y_coordinates: 7, game_id: self.id) # Black

    # Populate Knights
      Piece.create(name: 'Knight', x_coordinates: 1, y_coordinates: 0, game_id: self.id ) # White
      Piece.create(name: 'Knight', x_coordinates: 6, y_coordinates: 0, game_id: self.id ) # White
      Piece.create(name: 'Knight', x_coordinates: 1, y_coordinates: 7, game_id: self.id ) # Black
      Piece.create(name: 'Knight', x_coordinates: 6, y_coordinates: 7, game_id: self.id ) # Black

    # Populate Bishop
      Piece.create(name: 'Bishop', x_coordinates: 2, y_coordinates: 0, game_id: self.id) # White
      Piece.create(name: 'Bishop', x_coordinates: 5, y_coordinates: 0, game_id: self.id) # White
      Piece.create(name: 'Bishop', x_coordinates: 2, y_coordinates: 7, game_id: self.id) # Black
      Piece.create(name: 'Bishop', x_coordinates: 5, y_coordinates: 7, game_id: self.id) # Black

    # Populate Queen
      Piece.create(name: 'Queen', x_coordinates: 3, y_coordinates: 0, game_id: self.id) # White
      Piece.create(name: 'Queen', x_coordinates: 3, y_coordinates: 7, game_id: self.id) # Black

    # Populate King
      Piece.create(name: 'King', x_coordinates: 4, y_coordinates: 0, game_id: self.id) # White
      Piece.create(name: 'King', x_coordinates: 4, y_coordinates: 7, game_id: self.id) # Black

  end

end
