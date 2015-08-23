class RenameFKeyFieldsOnParticipantFrames2 < ActiveRecord::Migration
  def change
    rename_column :participant_frames, :bs1, :frame_id
    rename_column :participant_frames, :bs2, :participant_id
  end
end
