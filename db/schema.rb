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

ActiveRecord::Schema.define(version: 20170918125037) do

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "gadgets", force: :cascade do |t|
    t.string   "gadget_type"
    t.integer  "user_id",                         null: false
    t.text     "description"
    t.integer  "price"
    t.string   "address"
    t.boolean  "active",          default: false
    t.integer  "instant",         default: 1
    t.string   "listing_name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "has_guarantee"
    t.boolean  "has_manual"
    t.boolean  "has_content"
    t.boolean  "has_no_setup"
    t.boolean  "has_battery"
    t.string   "require_mobile"
    t.string   "require_account"
    t.index ["user_id"], name: "index_gadgets_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.boolean  "read",       default: false
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["message_id"], name: "index_notifications_on_message_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "gadget_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gadget_id"], name: "index_photos_on_gadget_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "price",                  null: false
    t.integer  "status",     default: 0, null: false
    t.datetime "start_date",             null: false
    t.datetime "end_date",               null: false
    t.integer  "user_id",                null: false
    t.integer  "gadget_id",              null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["gadget_id"], name: "index_reservations_on_gadget_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.integer  "star",           default: 1
    t.integer  "gadget_id"
    t.integer  "reservation_id"
    t.integer  "owner_id",                   null: false
    t.integer  "guest_id",                   null: false
    t.string   "type"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["gadget_id"], name: "index_reviews_on_gadget_id"
    t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.string   "nickname"
    t.string   "phone_number"
    t.text     "introduction"
    t.string   "provider"
    t.string   "uid"
    t.string   "sns_image"
    t.string   "local_image"
    t.string   "address"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
