require 'test_helper'
require 'pry-rails'

class GameTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

   test "foreign_key associations" do

      User.create(:email => "a@example.com", :password => "123456", :password_confirmation => "123456").save(:validate => false)
      User.create(:email => "b@example.com", :password => "123456", :password_confirmation => "123456").save(:validate => false)

      g = Game.create(:black_user_id => "1", :white_user_id => "2")
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

end
