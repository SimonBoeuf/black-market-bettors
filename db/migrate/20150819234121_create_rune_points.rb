class CreateRunePoints < ActiveRecord::Migration
  def change
    create_table :rune_points do |t|

      t.timestamps
    end
  end
end
