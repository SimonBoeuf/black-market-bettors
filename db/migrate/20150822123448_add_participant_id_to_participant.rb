class AddParticipantIdToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :participantId, :integer
  end
end
