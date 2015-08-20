class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.integer :timeline_id, index: true
      t.timestamps
    end
  end
end
