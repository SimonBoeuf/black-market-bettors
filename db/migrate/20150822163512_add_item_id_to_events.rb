class AddItemIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :itemId, :integer
  end
end
