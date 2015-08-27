class ChangeGameTimestamp < ActiveRecord::Migration
  def change
    change_column :games, :matchCreation, :bigint
  end
end
