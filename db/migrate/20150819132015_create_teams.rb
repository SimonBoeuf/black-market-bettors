class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :team_id
      t.integer :game_id
      t.timestamps
    end
  end
end
