require 'test_helper'

class PiecesControllerTest < ActionController::TestCase
  test "valid pawn move" do
    g = Game.create(white_user_id: 1, black_user_id: 2)
    white_pawn1 = g.pieces.find_by(x_coordinates: 1, y_coordinates: 1)
    put :update, id: white_pawn1.id, x_coordinates: 1, y_coordinates: 3
    assert_response :redirect
  end

  test "invalid pawn move" do
    g = Game.create(white_user_id: 1, black_user_id: 2)
    white_pawn2 = g.pieces.find_by(x_coordinates: 2, y_coordinates: 1)
    put :update, id: white_pawn2.id, x_coordinates: 2, y_coordinates: 4
    assert_response :redirect
  end
end
