class RemoveParticpantIdFromParticipant < ActiveRecord::Migration
  def change
    remove_column :participants, :particpantId
  end
end
