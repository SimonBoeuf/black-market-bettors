class AddWinnerToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :winner, :boolean
  end
end
