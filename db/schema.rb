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

ActiveRecord::Schema.define(version: 20160613215951) do

  create_table "authorized_user", force: :cascade do |t|
    t.string   "user_id"
    t.string   "user_name"
    t.string   "unicorn_updates"
    t.string   "direct_upload"
    t.string   "unicorn_circ_batch"
    t.string   "priv_approval"
    t.string   "email_stats"
    t.string   "priv_support"
    t.string   "db_access_ids"
    t.string   "priceforbills"
    t.string   "reset_recall_counter"
    t.string   "mgt_rpts"
    t.string   "ora_admin"
    t.string   "sal3_batch_req"
    t.string   "file_upload"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "sal3_batch_requests_batch", force: :cascade do |t|
    t.integer  "batch_id"
    t.string   "batch_name"
    t.string   "user_name"
    t.string   "user_email"
    t.string   "user_phone"
    t.string   "user_sunetid"
    t.string   "status"
    t.integer  "priority"
    t.string   "batch_container"
    t.string   "batch_media"
    t.datetime "batch_startdate"
    t.datetime "batch_needbydate"
    t.integer  "batch_numpullperday"
    t.string   "batch_pullmon"
    t.string   "batch_pulltues"
    t.string   "batch_pullwed"
    t.string   "batch_pullthurs"
    t.string   "batch_pullfri"
    t.string   "stopcode"
    t.string   "pseudo_id"
    t.string   "comments"
    t.integer  "ckey"
    t.string   "bc_file"
    t.integer  "num_bcs"
    t.integer  "num_nonsymph_bcs"
    t.integer  "num_retrieval_err"
    t.string   "pending"
    t.datetime "load_date"
    t.datetime "last_action_date"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "sal3_batch_requests_bcs", force: :cascade do |t|
    t.integer  "batch_id"
    t.string   "pending"
    t.datetime "load_date"
    t.integer  "priority"
    t.string   "item_id"
    t.datetime "run_date"
    t.datetime "completed_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "uni_updates", force: :cascade do |t|
    t.integer  "batch_id"
    t.string   "pending"
    t.string   "export_yn"
    t.datetime "load_date"
    t.integer  "priority"
    t.string   "action"
    t.string   "item_id"
    t.datetime "run_date"
    t.string   "to_delete_date"
    t.datetime "completed_date"
    t.string   "curr_lib"
    t.string   "new_lib"
    t.string   "new_itype"
    t.string   "new_homeloc"
    t.string   "new_curloc"
    t.string   "check_bc_first"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "uni_updates_batch", primary_key: "batch_id", force: :cascade do |t|
    t.datetime "batch_date"
    t.string   "user_name"
    t.string   "user_email"
    t.string   "action"
    t.integer  "priority"
    t.string   "export_yn"
    t.string   "check_bc_first"
    t.string   "orig_lib"
    t.string   "new_lib"
    t.string   "new_homeloc"
    t.string   "new_curloc"
    t.string   "new_itype"
    t.integer  "total_bcs"
    t.string   "pending"
    t.string   "comments"
    t.integer  "num_errors"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "uni_updates_errors", force: :cascade do |t|
    t.string "run"
    t.string "batch"
    t.string "item_id"
    t.string "call_num"
    t.string "shelving_key"
    t.string "msg"
  end

  create_table "unicorn_policies", force: :cascade do |t|
    t.string   "type"
    t.integer  "policy_num"
    t.string   "name"
    t.string   "description"
    t.string   "shadowed"
    t.string   "destination"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
