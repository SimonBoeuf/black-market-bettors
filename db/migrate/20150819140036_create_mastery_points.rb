class CreateMasteryPoints < ActiveRecord::Migration
  def change
    create_table :mastery_points do |t|
      t.integer :participant_id, index: true
      t.integer :static_data_mastery_id, index: true
      t.integer :rank
      t.timestamps
    end
  end
end
