class CreateStaticDataSkins < ActiveRecord::Migration
  def change
    create_table :static_data_skins do |t|
      t.references :champion, index: true
      t.string :name
      t.integer :num

      t.timestamps
    end
  end
end
