class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :static_data_champion_id, index: true
      t.integer :game_id
      t.integer :highestAchievedSeasonTier
      t.integer :particpantId
      t.integer :spell1_id, index: true
      t.integer :spell2_id, index: true
      t.integer :team_id, index: true
      t.timestamps
    end
  end
end
