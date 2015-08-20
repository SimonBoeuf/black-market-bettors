class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|

      t.timestamps
    end
  end
end
