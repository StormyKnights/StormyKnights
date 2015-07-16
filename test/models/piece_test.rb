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

end
