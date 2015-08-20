class CreateStaticDataSummonerSpells < ActiveRecord::Migration
  def change
    create_table :static_data_summoner_spells do |t|
      t.string :name
      t.integer :image_id
      t.timestamps
    end
  end
end
