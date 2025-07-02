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

ActiveRecord::Schema[8.0].define(version: 2025_07_02_194030) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "node_tree_paths", force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.index ["ancestor_id", "descendant_id"], name: "index_node_tree_paths_on_ancestor_id_and_descendant_id", unique: true
    t.index ["ancestor_id"], name: "index_node_tree_paths_on_ancestor_id"
    t.index ["descendant_id"], name: "index_node_tree_paths_on_descendant_id"
  end

  create_table "nodes", force: :cascade do |t|
  end
end
