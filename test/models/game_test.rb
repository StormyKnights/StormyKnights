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

   # test "is_occupied" do

   #  g = Game.create(white_user_id: 1, black_user_id: 2)
    
   #  assert_equal true, g.occupied?(4, 7)
   #  assert_equal true, g.obstructed?([0, 0], [3, 0])
   #  assert_equal true, g.obstructed?([1, 0], [1, 3])
   #  assert_equal true, g.obstructed?([2, 0], [4, 2])
   #  assert_equal true, g.obstructed?([4, 2], [2, 0])
   #  assert_equal false, g.obstructed?([0, 2], [2, 4])
   #  assert_equal false, g.obstructed?([1, 3], [5, 3])
   #  assert_equal false, g.obstructed?([4, 2], [4, 5])
   #  assert_raise RuntimeError do
   #    g.obstructed?([3, 0], [4, 2])
   #  end
   # end

end
