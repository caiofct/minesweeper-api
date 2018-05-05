class CreateGrids < ActiveRecord::Migration[5.2]
  def change
    create_table :grids do |t|
      t.integer :width
      t.integer :height
      t.integer :status, default: 1
      t.integer :number_of_mines
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
