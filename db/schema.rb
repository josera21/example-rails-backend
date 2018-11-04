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

ActiveRecord::Schema.define(version: 20170717131038) do

  create_table "activities", force: :cascade do |t|
    t.string "trackable_type"
    t.integer "trackable_id"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "key"
    t.text "parameters"
    t.string "recipient_type"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
    t.index ["owner_type", "owner_id"], name: "index_activities_on_owner_type_and_owner_id"
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
    t.index ["recipient_type", "recipient_id"], name: "index_activities_on_recipient_type_and_recipient_id"
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "nombre"
    t.string "extension"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_attachments_on_post_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["usuario_id"], name: "index_friendships_on_usuario_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "post_id"
    t.integer "usuario_id"
    t.integer "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_payments_on_post_id"
    t.index ["usuario_id"], name: "index_payments_on_usuario_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "titulo"
    t.text "contenido"
    t.string "extension"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "costo", precision: 10, scale: 3
    t.index ["usuario_id"], name: "index_posts_on_usuario_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "token"
    t.string "payerid"
    t.integer "usuario_id"
    t.decimal "total", precision: 10, scale: 3
    t.string "respuesta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip_address"
    t.index ["usuario_id"], name: "index_transactions_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "username"
    t.string "nombre"
    t.string "apellido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

end
