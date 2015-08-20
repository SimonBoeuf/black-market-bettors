class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :frame_id
      t.integer :ascendedType
      t.integer :buildingType
      t.integer :evenType
      t.integer :laneType
      t.integer :levelUpType
      t.integer :monsterType
      t.integer :pointCaptured
      t.integer :towerType
      t.integer :wardType
      t.integer :creatorId
      t.integer :itemAfter
      t.integer :itemBefore
      t.integer :killerId
      t.integer :participantId
      t.integer :positionX
      t.integer :positionY
      t.integer :skillSlot
      t.integer :teamId
      t.integer :timeStamp
      t.integer :victimId
      t.timestamps
    end
  end
end
