class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|

      t.string  :name
      t.integer :x_coordinates
      t.integer :y_coordinates
      t.integer :game_id

      
      t.timestamps
    end
  end
end
