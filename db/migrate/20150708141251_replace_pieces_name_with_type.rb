class ReplacePiecesNameWithType < ActiveRecord::Migration
  def change
  	# add type column and deleted the name column
  	add_column :pieces, :type, :string
  	remove_column :pieces, :name
  end
end
