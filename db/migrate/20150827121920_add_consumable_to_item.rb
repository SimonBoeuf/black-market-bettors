class AddConsumableToItem < ActiveRecord::Migration
  def change
    add_column :static_data_items, :consumable, :boolean
  end
end
