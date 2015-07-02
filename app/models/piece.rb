class Piece < ActiveRecord::Base

  belongs_to :game
  belongs_to :white_user_id, :class_name => "User", :foreign_key => "white_user_id"
  belongs_to :black_user_id, :class_name => "User", :foreign_key => "black_user_id"

end
