class CreateSquares < ActiveRecord::Migration[5.2]
  def change
    create_table :squares do |t|
      t.integer :x
      t.integer :y
      t.integer :mines, default: 0
      t.references :grid, foreign_key: true
      t.boolean :flagged, default: false
      t.boolean :explored, default: false
      t.boolean :mine, default: false

      t.timestamps
    end
  end
end
