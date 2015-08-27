class ChangeSomeTypesAgain < ActiveRecord::Migration
  def change
    change_column :games, :matchId, :bigint
  end
end
