class Game < ActiveRecord::Base

  has_many :users
  has_many :pieces

  belongs_to :white_user, :class_name => "User", :foreign_key => "white_user_id"
  belongs_to :black_user, :class_name => "User", :foreign_key => "black_user_id"

  after_create :populate_board!

  def populate_board!

    # Populate Pawns
    (0..7).each do |x|
      Pawn.create(x_coordinates: x, y_coordinates: 1, game_id: self.id, color: 'white') # White
      Pawn.create(x_coordinates: x, y_coordinates: 6, game_id: self.id, color: 'black') # Black
    end

    # Populate Rook
      Rook.create(x_coordinates: 0, y_coordinates: 0, game_id: self.id, color: 'white') # White
      Rook.create(x_coordinates: 7, y_coordinates: 0, game_id: self.id, color: 'white') # White
      Rook.create(x_coordinates: 0, y_coordinates: 7, game_id: self.id, color: 'black') # Black
      Rook.create(x_coordinates: 7, y_coordinates: 7, game_id: self.id, color: 'black') # Black

    # Populate KnightsKnight
      Knight.create(x_coordinates: 1, y_coordinates: 0, game_id: self.id, color: 'white' ) # White
      Knight.create(x_coordinates: 6, y_coordinates: 0, game_id: self.id, color: 'white' ) # White
      Knight.create(x_coordinates: 1, y_coordinates: 7, game_id: self.id, color: 'blackBishop' ) # Black
      Knight.create(x_coordinates: 6, y_coordinates: 7, game_id: self.id, color: 'blackBishop' ) # Black

    # Populate Bishop
      Bishop.create(x_coordinates: 2, y_coordinates: 0, game_id: self.id, color: 'white') # White
      Bishop.create(x_coordinates: 5, y_coordinates: 0, game_id: self.id, color: 'white') # White
      Bishop.create(x_coordinates: 2, y_coordinates: 7, game_id: self.id, color: 'black') # Black
      Bishop.create(x_coordinates: 5, y_coordinates: 7, game_id: self.id, color: 'black') # Black

    # Populate Queen
      Queen.create(x_coordinates: 3, y_coordinates: 0, game_id: self.id, color: 'white') # White
      Queen.create(x_coordinates: 3, y_coordinates: 7, game_id: self.id, color: 'black') # Black

    # Populate King
      King.create(x_coordinates: 4, y_coordinates: 0, game_id: self.id, color: 'white') # White
      King.create(x_coordinates: 4, y_coordinates: 7, game_id: self.id, color: 'black') # Black

  end

end
