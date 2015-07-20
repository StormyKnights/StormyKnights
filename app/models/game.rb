class Game < ActiveRecord::Base

  has_many :users
  has_many :pieces

  belongs_to :white_user, class_name: 'User', foreign_key: 'white_user_id'
  belongs_to :black_user, class_name: 'User', foreign_key: 'black_user_id'

  after_create :populate_board!

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

  # determines whether the square with coordinates (x, y) is occupied
  def occupied?(x, y)
    self.pieces.where(:x_coordinates => x, :y_coordinates => y).present?
    # pieces.each do |piece|
    #   return true if piece.x_coordinates == x && piece.y_coordinates == y
    # end
    # false
  end

  def check_path(x1, y1, x2, y2)
    if y1 == y2
      return 'horizontal'
    elsif x1 == x2
      return 'vertical'
    else
      @slope = (y2 - y1).to_f/(x2 - x1).to_f
      slope
    end
  end

  def slope
    @slope
  end


end
