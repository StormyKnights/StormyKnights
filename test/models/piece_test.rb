require 'test_helper'

class PieceTest < ActiveSupport::TestCase

  test "valid rook move" do
    g = Game.create(white_user_id: 1, black_user_id: 2)
    rook1 = g.pieces.find_by(type: 'Rook', color: 'white', x_coordinates: 0, y_coordinates: 0)
    rook2 = g.pieces.find_by(type: 'Rook', color: 'white', x_coordinates: 7, y_coordinates: 0)

    rook1.assign_attributes({x_coordinates: 0, y_coordiantes: 5}) #move up 5 spaces
    assert rook1.valid?
    
    # assert_equal true, rook1.valid_move?(5,0) #move horizontal 5 spaces
    # assert_equal true, rook2.valid_move?(7,3) 
    # assert_equal true, rook2.valid_move?(2,0) 
  end

  # test "not valid rook move" do
  #   g = Game.create(white_user_id: 1, black_user_id: 2)
  #   rook1 = g.pieces.find_by(type: 'Rook', color: 'white', x_coordinates: 0, y_coordinates: 0)
  #   rook2 = g.pieces.find_by(type: 'Rook', color: 'white', x_coordinates: 7, y_coordinates: 0)

  #   # assert_equal false, rook1.valid_move?(1,1) #move diagonally from left position
  #   # assert_equal false, rook2.valid_move?(5,2) #move diagonally from right position
  # end




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
