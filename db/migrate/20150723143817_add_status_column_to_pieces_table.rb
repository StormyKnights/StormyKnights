class AddStatusColumnToPiecesTable < ActiveRecord::Migration
  def change
    add_column :pieces, :status, :string
  end
end
