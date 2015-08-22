class AddTimestampToFrame < ActiveRecord::Migration
  def change
    add_column :frames, :timestamp, :integer
  end
end
