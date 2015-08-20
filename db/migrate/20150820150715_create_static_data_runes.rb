class CreateStaticDataRunes < ActiveRecord::Migration
  def change
    create_table :static_data_runes do |t|
      t.integer :image_id, index: true
      t.text :sanitized_description
      t.string :name
      t.string :type
      t.timestamps
    end
  end
end
