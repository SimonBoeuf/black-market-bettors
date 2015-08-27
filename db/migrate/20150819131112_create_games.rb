class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :mapId
      t.integer :matchCreation
      t.integer :matchDuration
      t.integer :matchId, limit: 8
      t.integer :matchMode
      t.integer :matchType
      t.string :matchVersion
      t.string :platformId
      t.integer :queueType
      t.string :region
      t.integer :season
      t.integer :blue_team_id, index: true
      t.integer :red_team_id, index: true
      t.integer :timeline_id, index: true
      t.timestamps
    end
  end
end
