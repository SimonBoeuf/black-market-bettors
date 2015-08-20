class CreateParticipantStats < ActiveRecord::Migration
  def change
    create_table :participant_stats do |t|

      t.timestamps
    end
  end
end
