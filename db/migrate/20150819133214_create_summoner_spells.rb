class CreateSummonerSpells < ActiveRecord::Migration
  def change
    create_table :summoner_spells do |t|

      t.timestamps
    end
  end
end
