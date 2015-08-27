class AddConsumedToStaticDataItem < ActiveRecord::Migration
  def change
    add_column :static_data_items, :consumed, :boolean
  end
end
