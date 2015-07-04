class Game < ActiveRecord::Base

  has_many :users
  has_many :pieces

  belongs_to :white_user, :class_name => "User", :foreign_key => "white_user_id"
  belongs_to :black_user, :class_name => "User", :foreign_key => "black_user_id"

end
