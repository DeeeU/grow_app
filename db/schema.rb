# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_12_15_021807) do
  create_table "binaries", force: :cascade do |t|
    t.string "title"
    t.string "context"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "binaries_tags", id: false, force: :cascade do |t|
    t.integer "binary_id", null: false
    t.integer "tag_id", null: false
    t.index ["binary_id"], name: "index_binaries_tags_on_binary_id"
    t.index ["tag_id"], name: "index_binaries_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "color", default: "#FFFFFF", null: false
    t.string "context"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
