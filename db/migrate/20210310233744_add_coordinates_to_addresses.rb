class AddCoordinatesToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :lat, :decimal, :precision => 15, :scale => 8
    add_column :addresses, :lng, :decimal, :precision => 15, :scale => 8
  end
end
