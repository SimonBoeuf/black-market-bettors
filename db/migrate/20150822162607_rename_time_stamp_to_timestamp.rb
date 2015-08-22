class RenameTimeStampToTimestamp < ActiveRecord::Migration
  def change
    rename_column :events, :timeStamp, :timestamp
  end
end
