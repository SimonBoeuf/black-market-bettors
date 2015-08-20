class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.integer :frame_interval
      t.integer :game_id
      t.timestamps
    end
  end
end
