class AddPositionToParticipantFrames < ActiveRecord::Migration
  def change
    add_column :participant_frames, :positionX, :integer
    add_column :participant_frames, :positionY, :integer
  end
end
