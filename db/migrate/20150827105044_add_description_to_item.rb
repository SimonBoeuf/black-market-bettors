class AddDescriptionToItem < ActiveRecord::Migration
  def change
    add_column :static_data_items, :description, :text
  end
end
