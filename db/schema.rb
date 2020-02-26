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

ActiveRecord::Schema.define(version: 2020_02_25_225131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.integer "auth_id"
    t.string "name"
    t.string "email"
    t.string "authorable_type"
    t.bigint "authorable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authorable_type", "authorable_id"], name: "index_authors_on_authorable_type_and_authorable_id"
  end

  create_table "commits", force: :cascade do |t|
    t.string "sha"
    t.string "tickets"
    t.datetime "date"
    t.bigint "author_id"
    t.string "commitable_type"
    t.bigint "commitable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_commits_on_author_id"
    t.index ["commitable_type", "commitable_id"], name: "index_commits_on_commitable_type_and_commitable_id"
  end

  create_table "heads", force: :cascade do |t|
    t.string "sha"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pull_requests", force: :cascade do |t|
    t.integer "request_id"
    t.integer "number"
    t.string "state"
    t.string "title"
    t.bigint "user_id"
    t.string "body"
    t.datetime "closed_at"
    t.string "merge_commit_sha"
    t.bigint "head_id"
    t.integer "commits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["head_id"], name: "index_pull_requests_on_head_id"
    t.index ["user_id"], name: "index_pull_requests_on_user_id"
  end

  create_table "pulls", force: :cascade do |t|
    t.string "action"
    t.integer "number"
    t.bigint "pull_request_id"
    t.bigint "repository_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pull_request_id"], name: "index_pulls_on_pull_request_id"
    t.index ["repository_id"], name: "index_pulls_on_repository_id"
  end

  create_table "pushers", force: :cascade do |t|
    t.integer "pusher_id"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pushes", force: :cascade do |t|
    t.bigint "commits_id"
    t.bigint "repository_id"
    t.datetime "pushed_at"
    t.bigint "pusher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commits_id"], name: "index_pushes_on_commits_id"
    t.index ["pusher_id"], name: "index_pushes_on_pusher_id"
    t.index ["repository_id"], name: "index_pushes_on_repository_id"
  end

  create_table "releases", force: :cascade do |t|
    t.string "action"
    t.datetime "released_at"
    t.integer "release_id"
    t.string "tag_name"
    t.bigint "author_id"
    t.bigint "commits_id"
    t.bigint "repository_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_releases_on_author_id"
    t.index ["commits_id"], name: "index_releases_on_commits_id"
    t.index ["repository_id"], name: "index_releases_on_repository_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.integer "repo_id"
    t.string "name"
    t.string "repositable_type"
    t.bigint "repositable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repositable_type", "repositable_id"], name: "index_repositories_on_repositable_type_and_repositable_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "usr_id"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "commits", "authors"
  add_foreign_key "pull_requests", "heads"
  add_foreign_key "pull_requests", "users"
  add_foreign_key "pulls", "pull_requests"
  add_foreign_key "pulls", "repositories"
  add_foreign_key "pushes", "commits", column: "commits_id"
  add_foreign_key "pushes", "pushers"
  add_foreign_key "pushes", "repositories"
  add_foreign_key "releases", "authors"
  add_foreign_key "releases", "commits", column: "commits_id"
  add_foreign_key "releases", "repositories"
end
