class CreateMasteryPoints < ActiveRecord::Migration
  def change
    create_table :mastery_points do |t|

      t.timestamps
    end
  end
end
