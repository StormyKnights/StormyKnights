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

  test "valid knight move" do

    g = Game.create(white_user_id: 1, black_user_id: 2)
    knight = g.pieces.find_by(type: 'Knight', color: 'white', x_coordinates: 1, y_coordinates: 0)

    # Valid Moves From Starting position (1, 0)
    assert_equal true, knight.valid_move?(3,1)  # Move 1 up and 2 right from starting position
    assert_equal true, knight.valid_move?(2,2)  # Move 2 up and 1 right from starting position
    assert_equal true, knight.valid_move?(0,2)  # Move 2 up and 1 left from starting position

    knight = g.pieces.find_by(type: 'Knight', color: 'white', x_coordinates: 6, y_coordinates: 0)

    # Valid Moves From Starting position (6, 0)
    assert_equal true, knight.valid_move?(7,2)  # Move 2 up and 1 right from starting position
    assert_equal true, knight.valid_move?(5,2)  # Move 2 up and 1 left from starting position
    assert_equal true, knight.valid_move?(4,1)  # Move 2 up and 1 left from starting position

    knight = g.pieces.find_by(type: 'Knight', color: 'black', x_coordinates: 1, y_coordinates: 7)

    # Valid Moves From Starting position (1, 7)
    assert_equal true, knight.valid_move?(0,5)  # Move 2 down and 1 left from starting position
    assert_equal true, knight.valid_move?(2,5)  # Move 2 down and 1 right from starting position
    assert_equal true, knight.valid_move?(3,6)  # Move 1 down and 2 right from starting position

    knight = g.pieces.find_by(type: 'Knight', color: 'black', x_coordinates: 6, y_coordinates: 7)

    # Valid Moves From Starting position (6, 7)
    assert_equal true, knight.valid_move?(7,5)  # Move 2 down and 1 right from starting position
    assert_equal true, knight.valid_move?(5,5)  # Move 2 down and 1 left from starting position
    assert_equal true, knight.valid_move?(4,6)  # Move 1 down and 2 left from starting position

  end

end
