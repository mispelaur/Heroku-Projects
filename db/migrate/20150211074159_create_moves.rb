class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.integer :move_coordinate

      t.timestamps null: false
    end
  end
end
