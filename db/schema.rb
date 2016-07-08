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

ActiveRecord::Schema.define(version: 20160708184849) do

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

  create_table "circ_stats_rpt_fmts", force: :cascade do |t|
    t.string "format"
  end

  create_table "encumbrance_rpts", force: :cascade do |t|
    t.datetime "date_request"
    t.datetime "date_ran"
    t.string   "status"
    t.string   "email"
    t.string   "fund_acct"
    t.string   "fundcyc_cycle"
    t.string   "funding_paid"
    t.string   "output_file"
    t.string   "message"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "expenditures_circ_log", force: :cascade do |t|
    t.datetime "date_request"
    t.datetime "date_ran"
    t.string   "status"
    t.string   "email"
    t.string   "ta_fund_code"
    t.datetime "date_range_start"
    t.datetime "date_range_end"
    t.string   "libraries"
    t.string   "formats"
    t.integer  "one_row_total"
    t.string   "output_file"
    t.string   "message"
    t.integer  "ckey_link"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "expenditures_funds", force: :cascade do |t|
    t.string   "fund_id"
    t.string   "fund_name_key"
    t.string   "old_fund_id"
    t.datetime "min_pay_date"
    t.datetime "max_pay_date"
    t.integer  "is_endow"
    t.string   "inv_lib"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "expenditures_log", force: :cascade do |t|
    t.datetime "date_request"
    t.datetime "date_ran"
    t.string   "status"
    t.string   "email"
    t.string   "ta_fund_code"
    t.datetime "date_range_start"
    t.datetime "date_range_end"
    t.string   "output_file"
    t.string   "message"
    t.integer  "ckey_link"
    t.string   "path_invlin_fund_keys"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "expenditures_paydates", force: :cascade do |t|
    t.datetime "pay_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "shelf_sel_item_cat1s", force: :cascade do |t|
    t.string "item_category1"
  end

  create_table "shelf_sel_item_types", force: :cascade do |t|
    t.string "item_type"
  end

  create_table "shelf_sel_searches", force: :cascade do |t|
    t.string  "user_name"
    t.string  "search_name"
    t.string  "call_range"
    t.string  "lib"
    t.string  "locs"
    t.string  "fmts"
    t.string  "itypes"
    t.string  "min_yr"
    t.string  "max_yr"
    t.string  "min_circ"
    t.string  "max_circ"
    t.integer "na_i_e_shadow"
    t.integer "na_i_e_url"
    t.integer "na_i_e_dups"
    t.integer "na_i_e_boundw"
    t.integer "na_i_e_cloc_diff"
    t.integer "na_i_e_digisent"
    t.integer "na_i_e_mhlds"
    t.integer "na_i_e_multvol"
    t.integer "na_i_e_multcop"
    t.string  "lang"
    t.string  "icat1s"
  end

  create_table "uni_libs_locs", force: :cascade do |t|
    t.string "library"
    t.string "home_loc"
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
    t.string   "cur_lib"
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
