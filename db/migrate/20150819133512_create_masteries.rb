class CreateMasteries < ActiveRecord::Migration
  def change
    create_table :static_data_masteries do |t|
      t.integer :image_id
      t.string :name
      t.integer :mastery_tree
      t.timestamps
    end
  end
end
