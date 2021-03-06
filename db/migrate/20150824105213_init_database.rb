class InitDatabase < ActiveRecord::Migration
  def change
    create_table "active_admin_comments", force: :cascade do |t|
      t.string   "namespace"
      t.text     "body"
      t.string   "resource_id",   null: false
      t.string   "resource_type", null: false
      t.integer  "author_id"
      t.string   "author_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

    create_table "admins", force: :cascade do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet     "current_sign_in_ip"
      t.inet     "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
    add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

    create_table "conversation_participants", force: :cascade do |t|
      t.integer  "user_id",         null: false
      t.integer  "conversation_id", null: false
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end

    create_table "conversations", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string   "key",        null: false
    end

    create_table "divisions", force: :cascade do |t|
      t.integer  "team_id",    null: false
      t.integer  "game_id",    null: false
      t.string   "name",       null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "friendship_invites", force: :cascade do |t|
      t.integer  "from_user_id"
      t.integer  "to_user_id"
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end

    create_table "friendships", force: :cascade do |t|
      t.integer  "user_id",    null: false
      t.integer  "friend_id",  null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "game_ownerships", force: :cascade do |t|
      t.integer  "user_id",    null: false
      t.integer  "game_id",    null: false
      t.string   "nickname",   null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "game_rule_entries", force: :cascade do |t|
      t.integer  "game_rule_id", null: false
      t.string   "key",          null: false
      t.string   "value",        null: false
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end

    create_table "game_rules", force: :cascade do |t|
      t.integer  "game_id",    null: false
      t.string   "name",       null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "game_translations", force: :cascade do |t|
      t.integer  "game_id",     null: false
      t.string   "locale",      null: false
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
      t.text     "description"
    end

    add_index "game_translations", ["game_id"], name: "index_game_translations_on_game_id", using: :btree
    add_index "game_translations", ["locale"], name: "index_game_translations_on_locale", using: :btree

    create_table "games", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string   "name",       null: false
    end

    create_table "messages", force: :cascade do |t|
      t.integer  "user_id",         null: false
      t.integer  "conversation_id", null: false
      t.text     "text",            null: false
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end

    create_table "team_memberships", force: :cascade do |t|
      t.integer  "user_id",                    null: false
      t.integer  "team_id",                    null: false
      t.boolean  "captain",    default: false, null: false
      t.datetime "created_at",                 null: false
      t.datetime "updated_at",                 null: false
    end

    create_table "teams", force: :cascade do |t|
      t.string   "nickname",    null: false
      t.string   "description"
      t.string   "tag"
      t.datetime "created_at",  null: false
      t.datetime "updated_at",  null: false
      t.integer  "founder_id",  null: false
    end

    create_table "users", force: :cascade do |t|
      t.string   "email",                            default: "", null: false
      t.string   "encrypted_password",               default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",                    default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.inet     "current_sign_in_ip"
      t.inet     "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "nickname",                                      null: false
      t.integer  "flags_mask",             limit: 8, default: 0,  null: false
      t.text     "description"
      t.string   "sex"
      t.integer  "age"
      t.string   "nationality"
    end

    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end
end
