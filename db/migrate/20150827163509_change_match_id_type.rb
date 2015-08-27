class ChangeMatchIdType < ActiveRecord::Migration
  def change
    change_column :games, :id, :bigint
  end
end
