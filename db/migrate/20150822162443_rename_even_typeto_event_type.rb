class RenameEvenTypetoEventType < ActiveRecord::Migration
  def change
    rename_column :events, :evenType, :eventType
  end
end
