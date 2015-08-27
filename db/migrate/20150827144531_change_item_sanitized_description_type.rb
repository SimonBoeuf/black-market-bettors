class ChangeItemSanitizedDescriptionType < ActiveRecord::Migration
  def change
    change_column :static_data_items, :sanitizedDescription, :text
  end
end
