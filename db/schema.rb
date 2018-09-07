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

ActiveRecord::Schema.define(version: 20180808230015) do

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
    t.string   "sal3_breq_edit"
    t.string   "userload_rerun"
    t.string   "accession_number"
    t.string   "digital_bookplates"
    t.string   "edi_inv_manage"
    t.string   "edi_inv_view"
    t.string   "package_manage"
  end

  create_table "catnums", force: :cascade do |t|
    t.string   "item_type"
    t.string   "location"
    t.string   "prefix"
    t.integer  "seq_num"
    t.string   "resource_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "circ_stats_rpt_fmts", force: :cascade do |t|
    t.string "format"
  end

  create_table "circ_stats_rpt_log", force: :cascade do |t|
    t.datetime "date_request"
    t.datetime "date_ran"
    t.string   "status"
    t.string   "email"
    t.string   "call_range"
    t.string   "libs_locs"
    t.string   "format"
    t.integer  "include_inhouse"
    t.integer  "exclude_inactive"
    t.string   "blank_columns"
    t.string   "input_path"
    t.string   "output_name"
    t.string   "message"
    t.string   "extra_field"
    t.string   "extra_field2"
    t.string   "ckey_url"
    t.string   "extras_url"
    t.string   "link_type"
    t.integer  "selcall_src"
    t.string   "summary_only"
    t.integer  "min_pub_year"
    t.integer  "max_pub_year"
    t.string   "exclude_bad_year"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "digital_bookplates_batches", primary_key: "batch_id", force: :cascade do |t|
    t.string   "ckey_file"
    t.string   "druid"
    t.string   "user_name"
    t.string   "user_email"
    t.string   "batch_type"
    t.integer  "ckey_count"
    t.datetime "submit_date"
    t.datetime "completed_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "edi_error_report", force: :cascade do |t|
    t.datetime "run"
    t.string   "type"
    t.string   "error"
    t.string   "err_lvl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "edi_inv_line", primary_key: "tbl_row_num", force: :cascade do |t|
    t.string   "edi_vend_id"
    t.string   "edi_doc_num"
    t.integer  "edi_line_num"
    t.string   "edi_fund"
    t.string   "edi_po_number"
    t.float    "edi_line_net"
    t.float    "edi_line_gross"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "todo"
  end

  create_table "edi_inv_piece", force: :cascade do |t|
    t.string   "edi_vend_id"
    t.string   "edi_doc_num"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "edi_invoice", force: :cascade do |t|
    t.string   "edi_doc_num"
    t.string   "edi_vend_id"
    t.datetime "edi_vend_inv_date"
    t.string   "todo"
    t.datetime "uni_inv_cre_date"
    t.integer  "edi_total_pieces"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "edi_msg_id"
    t.string   "edi_msg_typ"
    t.string   "edi_msg_seg"
    t.integer  "uni_vend_key"
    t.string   "uni_accrue_or_pay_tax"
    t.string   "edi_stanfd_account"
    t.string   "uni_inv_lib"
    t.integer  "uni_inv_key"
    t.string   "uni_inv_num"
    t.integer  "edi_invc_total"
    t.integer  "uni_invc_total"
    t.integer  "edi_total_postage"
    t.integer  "edi_total_freight"
    t.integer  "edi_total_handling"
    t.integer  "edi_total_insurance"
    t.string   "edi_cur_code"
    t.integer  "edi_total_tax"
    t.integer  "edi_exchg_rate"
    t.integer  "edi_tax_rate"
  end

  create_table "edi_lin", force: :cascade do |t|
    t.string   "doc_num"
    t.string   "vend_id"
    t.integer  "edi_lin_num"
    t.integer  "edi_sublin_count"
    t.string   "vend_unique_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "barcode_num",      limit: 6
  end

  create_table "edi_sumrz_bib", force: :cascade do |t|
    t.string   "vend_code"
    t.string   "id001"
    t.integer  "edi_ckey"
    t.datetime "load_date"
    t.integer  "active_record"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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

  create_table "expenditures", force: :cascade do |t|
    t.datetime "row_date"
    t.datetime "review_date"
    t.integer  "ta_inv_line_key"
    t.string   "ta_fund_code"
    t.integer  "ta_fund_total_paid"
    t.string   "ta_gl_code"
    t.integer  "ta_ord_line_key"
    t.integer  "ta_inv_key"
    t.datetime "ta_date_2encina"
    t.string   "ta_encina_key"
    t.integer  "ta_invoice_total_withtax"
    t.integer  "ta_tax_total"
    t.string   "ta_taxtype_flag"
    t.datetime "ta_vend_inv_date"
    t.string   "ta_vend_inv_num"
    t.string   "ti_inv_lib"
    t.string   "ti_inv_line_note"
    t.string   "ti_inv_line_num"
    t.integer  "ti_inv_line_total_us"
    t.string   "ti_unicorn_inv_num"
    t.string   "ti_inv_line_type"
    t.integer  "ti_inv_line_total_vendor"
    t.string   "ti_fiscal_cycle"
    t.string   "ti_vendor_alpha_id"
    t.string   "to_order_id"
    t.integer  "to_order_line_num"
    t.integer  "to_ord_key"
    t.string   "to_order_line_control_type"
    t.integer  "to_order_line_copies"
    t.datetime "to_order_line_cre_date"
    t.integer  "to_order_line_dollars_paid"
    t.string   "to_order_line_seg_type"
    t.datetime "ts_date_mailed"
    t.string   "ol_selector"
    t.string   "ol_cat_key"
    t.string   "ol_call_seq"
    t.string   "ds_hold_code"
    t.string   "d2_hldc_lib"
    t.string   "d2_hldc_loc"
    t.string   "d2_hldc_type"
    t.string   "sc_lib"
    t.string   "sc_id"
    t.string   "sc_cat1"
    t.string   "sc_cat2"
    t.datetime "or_create_date"
    t.string   "ca_title"
    t.string   "ca_author"
    t.string   "ca_year"
    t.string   "ca_place"
    t.string   "ca_lang"
    t.string   "ca_pub260"
    t.string   "cn_callnum"
    t.string   "vn_name_key"
    t.string   "fn_name_key"
    t.string   "fn_level1"
    t.string   "fn_level2"
    t.string   "fn_level3"
    t.string   "fn_level4"
    t.string   "fn_fund_key"
    t.string   "fg_funding_key"
    t.string   "fg_fundcyc_key"
    t.string   "ca_fmt"
    t.string   "ca_020"
    t.string   "ca_022"
    t.string   "ca_024"
    t.string   "ca_series"
    t.string   "ca_962"
    t.string   "cn_shlv_key"
    t.string   "ol_volume"
    t.string   "i_created_by"
    t.string   "i_modified_by"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
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

  create_table "expenditures_fy_dates", force: :cascade do |t|
    t.integer  "fy"
    t.datetime "min_paydate"
    t.datetime "max_paydate"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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

  create_table "sal3_batch_requests_batch", primary_key: "batch_id", force: :cascade do |t|
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
    t.datetime "pull_date"
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

  create_table "uni_upd_mhld_errors", force: :cascade do |t|
    t.integer "batch_id"
    t.string  "flex"
    t.string  "err_msg"
    t.string  "format"
    t.string  "old_lib"
    t.string  "new_lib"
    t.string  "new_loc"
  end

  create_table "uni_updates", force: :cascade do |t|
    t.integer  "batch_id"
    t.string   "pending"
    t.string   "export_yn"
    t.date     "load_date"
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

  create_table "url_exclusions", force: :cascade do |t|
    t.string   "url_substring"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "vnd_packages", primary_key: "record_id", force: :cascade do |t|
    t.string   "package_id"
    t.string   "package_name"
    t.string   "package_status"
    t.string   "data_pickup_type"
    t.string   "afs_path"
    t.string   "ftp_server"
    t.string   "ftp_user"
    t.string   "ftp_password"
    t.string   "ftp_directory"
    t.string   "ftp_file_prefix"
    t.string   "ftp_list_type"
    t.string   "package_url"
    t.datetime "date_entered"
    t.string   "vendor_name"
    t.string   "holding_code"
    t.string   "comments"
    t.datetime "date_modified"
    t.string   "put_file_loc"
    t.string   "afs_search_string"
    t.string   "url_field"
    t.string   "vendor_id_read"
    t.string   "vendor_id_write"
    t.string   "access_note"
    t.string   "export_note"
    t.string   "junktag_file"
    t.string   "encoding_level"
    t.string   "vnd_catcode"
    t.string   "match_opts"
    t.string   "proc_type"
    t.string   "update_040"
    t.string   "rpt_mail"
    t.string   "access_urls_plats"
    t.string   "date_cat"
    t.string   "export_auth"
    t.string   "preprocess_modify_script"
    t.string   "preprocess_split_script"
    t.string   "preprocess_put_script"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
