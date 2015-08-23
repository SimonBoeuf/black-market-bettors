class CreateParticipantFrames < ActiveRecord::Migration
  def change
    create_table :participant_frames do |t|
      t.references :Participant, index: true
      t.integer :totalGold
      t.integer :level
      t.integer :minionsKilled
      t.integer :jungleMinionsKilled
      t.references :Frame, index: true

      t.timestamps
    end
  end
end
