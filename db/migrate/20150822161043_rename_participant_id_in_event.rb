class RenameParticipantIdInEvent < ActiveRecord::Migration
  def change
    rename_column :events, :participantId, :participant_id
  end
end
