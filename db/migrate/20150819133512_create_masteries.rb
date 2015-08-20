class CreateMasteries < ActiveRecord::Migration
  def change
    create_table :masteries do |t|

      t.timestamps
    end
  end
end
