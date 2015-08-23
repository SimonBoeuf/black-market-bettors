class RenameitemIdInEvent < ActiveRecord::Migration
  def change
    rename_column :events, :itemId, :item_id
  end
end
