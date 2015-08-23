class CreateStaticDataItems < ActiveRecord::Migration
  def change
    create_table :static_data_items do |t|
      t.string :name
      t.string :group
      t.string :sanitizedDescription
      t.string :plaintext
      t.references :image, index: true

      t.timestamps
    end
  end
end
