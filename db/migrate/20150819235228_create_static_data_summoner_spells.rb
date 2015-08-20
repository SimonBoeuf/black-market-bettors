class CreateStaticDataSummonerSpells < ActiveRecord::Migration
  def change
    create_table :static_data_summoner_spells do |t|

      t.timestamps
    end
  end
end
