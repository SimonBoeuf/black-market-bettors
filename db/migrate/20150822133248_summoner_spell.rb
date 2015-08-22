class SummonerSpell < ActiveRecord::Migration
  def change
    add_column :static_data_summoner_spells, :key, :string
  end
end
