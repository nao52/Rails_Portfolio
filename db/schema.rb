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

ActiveRecord::Schema[7.0].define(version: 2023_01_30_081229) do
  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "book_favorites", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "reference_book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference_book_id"], name: "index_book_favorites_on_reference_book_id"
    t.index ["user_id"], name: "index_book_favorites_on_user_id"
  end

  create_table "club_posts", charset: "utf8mb3", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "club_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "index_club_posts_on_club_id"
    t.index ["user_id", "created_at"], name: "index_club_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_club_posts_on_user_id"
  end

  create_table "clubs", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kinds_of_school_posts", charset: "utf8mb3", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "kinds_of_school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kinds_of_school_id"], name: "index_kinds_of_school_posts_on_kinds_of_school_id"
    t.index ["user_id", "created_at"], name: "index_kinds_of_school_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_kinds_of_school_posts_on_user_id"
  end

  create_table "kinds_of_schools", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "private_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["private_group_id"], name: "index_participations_on_private_group_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "private_group_posts", charset: "utf8mb3", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "private_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["private_group_id"], name: "index_private_group_posts_on_private_group_id"
    t.index ["user_id", "created_at"], name: "index_private_group_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_private_group_posts_on_user_id"
  end

  create_table "private_groups", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "detail"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_private_groups_on_user_id"
  end

  create_table "publishers", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_publishers_on_user_id"
  end

  create_table "reference_books", charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "publisher_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.index ["publisher_id"], name: "index_reference_books_on_publisher_id"
    t.index ["title"], name: "index_reference_books_on_title"
    t.index ["user_id"], name: "index_reference_books_on_user_id"
  end

  create_table "relationships", charset: "utf8mb3", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "subject_posts", charset: "utf8mb3", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_subject_posts_on_subject_id"
    t.index ["user_id", "created_at"], name: "index_subject_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_subject_posts_on_user_id"
  end

  create_table "subjects", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.bigint "subject_id", null: false
    t.bigint "club_id", null: false
    t.bigint "kinds_of_school_id", null: false
    t.index ["club_id"], name: "index_users_on_club_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["kinds_of_school_id"], name: "index_users_on_kinds_of_school_id"
    t.index ["subject_id"], name: "index_users_on_subject_id"
  end

  create_table "worksheet_favorites", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "worksheet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_worksheet_favorites_on_user_id"
    t.index ["worksheet_id"], name: "index_worksheet_favorites_on_worksheet_id"
  end

  create_table "worksheets", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.text "detail"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_worksheets_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_worksheets_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "book_favorites", "reference_books"
  add_foreign_key "book_favorites", "users"
  add_foreign_key "club_posts", "clubs"
  add_foreign_key "club_posts", "users"
  add_foreign_key "kinds_of_school_posts", "kinds_of_schools"
  add_foreign_key "kinds_of_school_posts", "users"
  add_foreign_key "participations", "private_groups"
  add_foreign_key "participations", "users"
  add_foreign_key "private_group_posts", "private_groups"
  add_foreign_key "private_group_posts", "users"
  add_foreign_key "private_groups", "users"
  add_foreign_key "publishers", "users"
  add_foreign_key "reference_books", "publishers"
  add_foreign_key "reference_books", "users"
  add_foreign_key "subject_posts", "subjects"
  add_foreign_key "subject_posts", "users"
  add_foreign_key "users", "clubs"
  add_foreign_key "users", "kinds_of_schools"
  add_foreign_key "users", "subjects"
  add_foreign_key "worksheet_favorites", "users"
  add_foreign_key "worksheet_favorites", "worksheets"
  add_foreign_key "worksheets", "users"
end
