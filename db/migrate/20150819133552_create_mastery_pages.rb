class CreateMasteryPages < ActiveRecord::Migration
  def change
    create_table :mastery_pages do |t|

      t.timestamps
    end
  end
end
