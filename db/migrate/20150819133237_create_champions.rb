class CreateChampions < ActiveRecord::Migration
  def change
    create_table :static_data_champions do |t|
      t.string :name
      t.string :key
      t.string :title
      t.text :lore
      t.integer :image_id
      t.integer :attack
      t.integer :defense
      t.integer :magic
      t.integer :difficulty
      t.timestamps
    end
  end
end
