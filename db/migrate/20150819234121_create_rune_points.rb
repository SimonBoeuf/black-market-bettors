class CreateRunePoints < ActiveRecord::Migration
  def change
    create_table :rune_points do |t|
      t.integer :participant_id, index: true
      t.integer :rune_id, index: true
      t.integer :rank
      t.timestamps
    end
  end
end
