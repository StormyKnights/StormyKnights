require 'test_helper'

class GameTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

   test "foreign_key associations" do

      User.create(email: "a@example.com", password: 123456, password_confirmation: 123456).save(validate: false)
      User.create(email: "b@example.com", password: 123456, password_confirmation: 123456).save(validate: false)

      g = Game.create(black_user_id: 1, white_user_id: 2)
      g = Game.last # loading last game into a variable

      u1 = User.first # loading user_id 1 as black_user
      u2 = User.last # loading user_id 2 as white_user

      g.black_user = u1
      g.white_user = u2
      g.save

      g = Game.last

      assert_equal u1, g.black_user
      assert_equal u2, g.white_user

   end

   test "board population" do

     g = Game.create(white_user_id: 1, black_user_id: 2)

     assert_equal 32, g.pieces.count
     assert_equal "King", g.pieces.last.type
     assert_equal 4, g.pieces.last.x_coordinates
     assert_equal 7, g.pieces.last.y_coordinates

   end

   test "obstructed?" do

     g = Game.create(white_user_id: 1, black_user_id: 2)
     piece1 = g.pieces.find_by(x_coordinates: 0, y_coordinates: 0)
     piece2 = g.pieces.find_by(x_coordinates: 2, y_coordinates: 0)
     piece3 = g.pieces.find_by(x_coordinates: 6, y_coordinates: 7)
     piece4 = g.pieces.find_by(x_coordinates: 6, y_coordinates: 6)
     piece5 = g.pieces.create( x_coordinates: 2, y_coordinates: 4, type: "Pawn", color: "white")

     assert_equal true, g.occupied?(4, 7)
     assert_equal true, piece1.obstructed?([3, 0])
     assert_equal true, piece2.obstructed?([2, 4])
     assert_equal true, piece2.obstructed?([0, 0])
     assert_equal true, piece3.obstructed?([3, 4])
     assert_equal true, piece4.obstructed?([3, 6])
     assert_equal false, piece4.obstructed?([6, 4])
     assert_equal false, piece5.obstructed?([6, 4])
     assert_equal false, piece5.obstructed?([0, 4])
     assert_raise RuntimeError do
       piece1.obstructed?([1, 2])
     end
  end

  test "capturing a piece of same color" do

    g = Game.create(white_user_id: 1, black_user_id: 2)
    white_pawn = g.pieces.find_by(x_coordinates: 1, y_coordinates: 1)
    assert_raise RuntimeError do
      white_pawn.move_to!(2, 1)   #moving to square occupied by piece of same color
    end
  end

  test "capturing a piece of different color by setting its coordinates to nil" do
  # Move to square occupied by piece of different color
  # Set coordinates of occupying piece to nil

    g = Game.create(white_user_id: 1, black_user_id: 2)
    white_pawn = g.pieces.find_by(x_coordinates: 1, y_coordinates: 1)
    assert_not_nil g.pieces.find_by(x_coordinates: 1, y_coordinates: 6)
    white_pawn.move_to!(1, 6)
    assert_nil g.pieces.find_by(x_coordinates: 1, y_coordinates: 6)
  end
end
