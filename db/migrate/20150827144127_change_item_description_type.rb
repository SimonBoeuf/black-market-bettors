class ChangeItemDescriptionType < ActiveRecord::Migration
  def change
    change_column :static_data_items, :description, :text
    change_column :static_data_items, :plaintext, :text
  end
end
