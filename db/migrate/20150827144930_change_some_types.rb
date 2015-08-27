class ChangeSomeTypes < ActiveRecord::Migration
  def change
    change_column :participants, :game_id, :bigint
    change_column :participants, :team_id, :bigint
    change_column :participants, :champion_id, :bigint
    change_column :participants, :spell1_id, :bigint
    change_column :participants, :spell2_id, :bigint
    change_column :events, :frame_id, :bigint
    change_column :events, :participant_id, :bigint
    change_column :frames, :timeline_id, :bigint
    change_column :games, :timeline_id, :bigint
    change_column :games, :blue_team_id, :bigint
    change_column :games, :red_team_id, :bigint
    change_column :games, :matchDuration, :bigint
    change_column :mastery_points, :participant_id, :bigint
    change_column :mastery_points, :mastery_id, :bigint
    change_column :rune_points, :participant_id, :bigint
    change_column :rune_points, :rune_id, :bigint
    change_column :teams, :game_id, :bigint
    change_column :timelines, :game_id, :bigint
    change_column :timelines, :frame_interval, :bigint
    change_column :static_data_champions, :image_id, :bigint
    change_column :static_data_items, :image_id, :bigint
    change_column :static_data_masteries, :image_id, :bigint
    change_column :static_data_masteries, :mastery_tree, :bigint
    change_column :static_data_runes, :image_id, :bigint
    change_column :static_data_skins, :champion_id, :bigint
    change_column :static_data_summoner_spells, :image_id, :bigint
  end
end
