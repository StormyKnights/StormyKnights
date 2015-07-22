require 'test_helper'

class PieceTest < ActiveSupport::TestCase


  test "valid king move" do

    g = Game.create(white_user_id: 1, black_user_id: 2)
    king = g.pieces.find_by(type: 'King', color: 'white')

    # Starting position (4,0)

    assert_equal true, king.valid_move?(3,0)    # Move left from starting position
    assert_equal true, king.valid_move?(3,1)    # Move up diagonally to the left from starting position
    assert_equal true, king.valid_move?(4,1)    # Move up from starting position
    assert_equal true, king.valid_move?(5,0)    # Move right from starting position
    assert_equal true, king.valid_move?(5,1)    # Move up diagonally to the right from starting position

  end

  test "not a valid king move" do

    g = Game.create(white_user_id: 1, black_user_id: 2)
    king = g.pieces.find_by(type: 'King', color: 'white')

    # Starting position (4,0)

    assert_equal false, king.valid_move?(4,2)    # Move 2 up from starting position
    assert_equal false, king.valid_move?(6,0)    # Move 2 right from starting position

  end

  test "valid rook move" do
    g = Game.create(white_user_id: 1, black_user_id: 2)
    rook1 = g.pieces.find_by(type: 'Rook', color: 'white', x_coordinates: 0, y_coordinates: 0)
    rook2 = g.pieces.find_by(type: 'Rook', color: 'white', x_coordinates: 7, y_coordinates: 0)

    rook1.assign_attributes({x_coordinates: 0, y_coordinates: 5}) #move up 5 spaces
    assert rook1.valid?
    
    assert_equal true, rook1.valid_move?(5,5) #move horizontal 5 spaces
    assert_equal false, rook2.valid_move?(7,3) #obstructed by pawn on line 6
    assert_equal false, rook2.valid_move?(2,0) #obstructed

    #add more tests against pieces in differen positions
  end

  test "not valid rook move" do
    g = Game.create(white_user_id: 1, black_user_id: 2)
    rook1 = g.pieces.find_by(type: 'Rook', color: 'white', x_coordinates: 0, y_coordinates: 0)
    rook2 = g.pieces.find_by(type: 'Rook', color: 'white', x_coordinates: 7, y_coordinates: 0)

    assert_equal false, rook1.valid_move?(1,1) #move diagonally from left position
    assert_equal false, rook2.valid_move?(5,2) #move diagonally from right position
  end




  # test "valid bishop move" do 
  #   g = Game.create(white_user_id: 1, black_user_id: 2)
  #   bishop1 = g.pieces.find_by(type: 'Bishop', color: 'white', x_coordinates: 2, y_coordinates: 0)
  #   bishop2 = g.pieces.find_by(type: 'Bishop', color: 'white', x_coordinates: 5, y_coordinates: 0)

  #   assert_equal true, bishop1.valid_move?(3,1)  
  #   assert_equal true, bishop2.valid_move?(3,2)

  # end

  # test "not valid bishop move" do
  #   g = Game.create(white_user_id: 1, black_user_id: 2)
  #   bishop1 = g.pieces.find_by(type: 'Bishop', color: 'white', x_coordinates: 2, y_coordinates: 0)
  #   bishop2 = g.pieces.find_by(type: 'Bishop', color: 'white', x_coordinates: 5, y_coordinates: 0)

  #   assert_equal false, bishop1.valid_move?(3,3)
  #   assert_equal false, bishop1.valid_move?(3,0)  
  # end


end
