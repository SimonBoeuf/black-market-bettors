# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150827144531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.integer  "frame_id"
    t.integer  "ascendedType"
    t.integer  "buildingType"
    t.integer  "eventType"
    t.integer  "laneType"
    t.integer  "levelUpType"
    t.integer  "monsterType"
    t.integer  "pointCaptured"
    t.integer  "towerType"
    t.integer  "wardType"
    t.integer  "creatorId"
    t.integer  "itemAfter"
    t.integer  "itemBefore"
    t.integer  "killerId"
    t.integer  "participant_id"
    t.integer  "positionX"
    t.integer  "positionY"
    t.integer  "skillSlot"
    t.integer  "teamId"
    t.integer  "timestamp"
    t.integer  "victimId"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
  end

  create_table "events_participants", force: true do |t|
    t.integer "event_id"
    t.integer "participant_id"
  end

  add_index "events_participants", ["event_id"], name: "index_events_participants_on_event_id", using: :btree
  add_index "events_participants", ["participant_id"], name: "index_events_participants_on_participant_id", using: :btree

  create_table "frames", force: true do |t|
    t.integer  "timeline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "timestamp"
  end

  create_table "games", force: true do |t|
    t.integer  "mapId"
    t.integer  "matchCreation", limit: 8
    t.integer  "matchDuration"
    t.integer  "matchId"
    t.integer  "matchMode"
    t.integer  "matchType"
    t.string   "matchVersion"
    t.string   "platformId"
    t.integer  "queueType"
    t.string   "region"
    t.integer  "season"
    t.integer  "blue_team_id"
    t.integer  "red_team_id"
    t.integer  "timeline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mastery_points", force: true do |t|
    t.integer  "participant_id"
    t.integer  "mastery_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participant_frames", force: true do |t|
    t.integer  "participant_id"
    t.integer  "totalGold"
    t.integer  "level"
    t.integer  "minionsKilled"
    t.integer  "jungleMinionsKilled"
    t.integer  "frame_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "positionX"
    t.integer  "positionY"
  end

  add_index "participant_frames", ["frame_id"], name: "index_participant_frames_on_frame_id", using: :btree
  add_index "participant_frames", ["participant_id"], name: "index_participant_frames_on_participant_id", using: :btree

  create_table "participants", force: true do |t|
    t.integer  "champion_id"
    t.integer  "game_id"
    t.integer  "highestAchievedSeasonTier"
    t.integer  "spell1_id"
    t.integer  "spell2_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participantId"
  end

  create_table "rune_points", force: true do |t|
    t.integer  "participant_id"
    t.integer  "rune_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_data_champions", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.string   "title"
    t.text     "lore"
    t.integer  "image_id"
    t.integer  "attack"
    t.integer  "defense"
    t.integer  "magic"
    t.integer  "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_data_images", force: true do |t|
    t.string   "full"
    t.string   "sprite"
    t.string   "group"
    t.integer  "x"
    t.integer  "y"
    t.integer  "w"
    t.integer  "h"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_data_items", force: true do |t|
    t.string   "name"
    t.string   "group"
    t.text     "sanitizedDescription"
    t.text     "plaintext"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.boolean  "consumable"
    t.boolean  "consumed"
  end

  add_index "static_data_items", ["image_id"], name: "index_static_data_items_on_image_id", using: :btree

  create_table "static_data_masteries", force: true do |t|
    t.integer  "image_id"
    t.string   "name"
    t.integer  "mastery_tree"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_data_runes", force: true do |t|
    t.integer  "image_id"
    t.text     "sanitized_description"
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "static_data_skins", force: true do |t|
    t.integer  "champion_id"
    t.string   "name"
    t.integer  "num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "static_data_skins", ["champion_id"], name: "index_static_data_skins_on_champion_id", using: :btree

  create_table "static_data_summoner_spells", force: true do |t|
    t.string   "name"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key"
  end

  create_table "teams", force: true do |t|
    t.integer  "team_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "winner"
  end

  create_table "timelines", force: true do |t|
    t.integer  "frame_interval"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
