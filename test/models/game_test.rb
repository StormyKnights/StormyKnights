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

   test "game in check" do
     g = Game.create(white_user_id: 1, black_user_id: 2)

     p = g.pieces.find_by(x_coordinates: 3, color: "white", type: "Pawn") # White Pawn
     k = g.pieces.find_by(x_coordinates: 4, type: "King", color: "black") # Black King

     p.update(x_coordinates: 3, y_coordinates: 4) # Update Pawn piece to x_coordinates: 3 & y_coordinates: 4
     k.update(x_coordinates: 4, y_coordinates: 5) # Update King piece to x_coordinates: 4 & y_coordinates: 5

     assert_equal true, g.in_check?("black")
   end

   test "game NOT in check" do
     g = Game.create(white_user_id: 1, black_user_id: 2)

     p = g.pieces.find_by(x_coordinates: 4, color: "white", type: "Pawn") # White Pawn
     k = g.pieces.find_by(x_coordinates: 4, type: "King", color: "black") # Black King

     p.update(x_coordinates: 4, y_coordinates: 4) # Update Pawn piece to x_coordinates: 4 & y_coordinates: 4
     k.update(x_coordinates: 4, y_coordinates: 5) # Update King piece to x_coordinates: 4 & y_coordinates: 5

     assert_equal false, g.in_check?("black")
   end
end
