class CreateEventsParticipants < ActiveRecord::Migration
  def change
    create_table :events_participants do |t|
      t.references :event, index: true
      t.references :participant, index: true
    end
  end
end
