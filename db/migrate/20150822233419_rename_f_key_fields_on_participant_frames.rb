class RenameFKeyFieldsOnParticipantFrames < ActiveRecord::Migration
  def change
    rename_column :participant_frames, :Frame_id, :bs1
    rename_column :participant_frames, :Participant_id, :bs2
  end
end
