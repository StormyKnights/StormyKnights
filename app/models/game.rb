class Game < ActiveRecord::Base

  has_many :users
  has_many :pieces

  belongs_to :white_user, class_name: 'User', foreign_key: 'white_user_id'
  belongs_to :black_user, class_name: 'User', foreign_key: 'black_user_id'

  after_create :populate_board!

  def populate_board!

    # Populate Pawns
    (0..7).each do |x|
      Pawn.create(x_coordinates: x, y_coordinates: 1, game_id: self.id, color: 'white', image: 'white-pawn.png') # White
      Pawn.create(x_coordinates: x, y_coordinates: 6, game_id: self.id, color: 'black', image: 'blk-pawn.png') # Black
    end

    # Populate Rook
      Rook.create(x_coordinates: 0, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-rook.png') # White
      Rook.create(x_coordinates: 7, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-rook.png') # White
      Rook.create(x_coordinates: 0, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-rook.png') # Black
      Rook.create(x_coordinates: 7, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-rook.png') # Black

    # Populate KnightsKnight
      Knight.create(x_coordinates: 1, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-knight.png' ) # White
      Knight.create(x_coordinates: 6, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-knight.png' ) # White
      Knight.create(x_coordinates: 1, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-knight.png' ) # Black
      Knight.create(x_coordinates: 6, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-knight.png' ) # Black

    # Populate Bishop
      Bishop.create(x_coordinates: 2, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-bishop.png') # White
      Bishop.create(x_coordinates: 5, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-bishop.png') # White
      Bishop.create(x_coordinates: 2, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-bishop.png') # Black
      Bishop.create(x_coordinates: 5, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-bishop.png') # Black

    # Populate Queen
      Queen.create(x_coordinates: 3, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-queen.png') # White
      Queen.create(x_coordinates: 3, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-queen.png') # Black

    # Populate King
      King.create(x_coordinates: 4, y_coordinates: 0, game_id: self.id, color: 'white', image: 'white-king.png') # White
      King.create(x_coordinates: 4, y_coordinates: 7, game_id: self.id, color: 'black', image: 'blk-king.png') # Black

  end

  