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

ActiveRecord::Schema[7.0].define(version: 2023_11_18_013942) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_reviews", force: :cascade do |t|
    t.bigint "livro_id", null: false
    t.bigint "user_id", null: false
    t.integer "rating"
    t.text "opinion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["livro_id"], name: "index_book_reviews_on_livro_id"
    t.index ["user_id"], name: "index_book_reviews_on_user_id"
  end

  create_table "favorite_books", force: :cascade do |t|
    t.bigint "livro_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["livro_id"], name: "index_favorite_books_on_livro_id"
    t.index ["user_id"], name: "index_favorite_books_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "livro_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["livro_id"], name: "index_favorites_on_livro_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "livros", force: :cascade do |t|
    t.text "imagem_caminho"
    t.string "titulo"
    t.string "autores"
    t.date "ano_lancamento"
    t.text "sinopse"
    t.integer "nota"
    t.string "editora"
    t.text "opiniao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "username", default: "", null: false
    t.date "birthday", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "book_reviews", "livros"
  add_foreign_key "book_reviews", "users"
  add_foreign_key "favorite_books", "livros"
  add_foreign_key "favorite_books", "users"
  add_foreign_key "favorites", "livros"
  add_foreign_key "favorites", "users"
end
