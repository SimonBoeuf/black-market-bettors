class CreateStaticDataImages < ActiveRecord::Migration
  def change
    create_table :static_data_images do |t|
      t.string :full
      t.string :sprite
      t.string :group
      t.integer :x
      t.integer :y
      t.integer :w
      t.integer :h
      t.timestamps
    end
  end
end
