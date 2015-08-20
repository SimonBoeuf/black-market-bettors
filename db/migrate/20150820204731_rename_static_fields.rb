class RenameStaticFields < ActiveRecord::Migration
  def change
    rename_column :participants, :static_data_champion_id, :champion_id
    rename_column :mastery_points, :static_data_mastery_id, :mastery_id
  end
end
