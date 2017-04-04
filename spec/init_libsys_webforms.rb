require 'csv'

UnicornPolicy.destroy_all
keys = %w(type policy_num name description shadowed destination)
csv_text = File.read(Rails.root.join('spec/fixtures/files/unicorn_policies.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
UnicornPolicy.create(hash)

ExpendituresFunds.destroy_all
keys = %w(fund_id fund_name_key old_fund_id min_pay_date max_pay_date is_endow inv_lib)
csv_text = File.read(Rails.root.join('spec/fixtures/files/expenditures_funds.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
ExpendituresFunds.create(hash)

ExpendituresPaydates.destroy_all
keys = ['pay_date']
csv_text = File.read(Rails.root.join('spec/fixtures/files/expenditures_paydates.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
ExpendituresPaydates.create(hash)

UniLibsLocs.destroy_all
keys = %w(library home_loc)
csv_text = File.read(Rails.root.join('spec/fixtures/files/uni_libs_locs.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
UniLibsLocs.create(hash)

ShelfSelectionItemType.destroy_all
keys = ['item_type']
csv_text = File.read(Rails.root.join('spec/fixtures/files/item_types.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
ShelfSelectionItemType.create(hash)

ShelfSelItemCat1.destroy_all
keys = ['item_category1']
csv_text = File.read(Rails.root.join('spec/fixtures/files/item_cat1.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
ShelfSelItemCat1.create(hash)

CirculationStatisticsReportFormat.destroy_all
keys = ['format']
csv_text = File.read(Rails.root.join('spec/fixtures/files/formats.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
CirculationStatisticsReportFormat.create(hash)

Expenditures.destroy_all
keys = %w(
  row_date
  review_date
  ta_inv_line_key
  ta_fund_code
  ta_fund_total_paid
  ta_gl_code
  ta_ord_line_key
  ta_inv_key
  ta_date_2encina
  ta_encina_key
  ta_invoice_total_withtax
  ta_tax_total
  ta_taxtype_flag
  ta_vend_inv_date
  ta_vend_inv_num
  ti_inv_lib
  ti_inv_line_note
  ti_inv_line_num
  ti_inv_line_total_us
  ti_unicorn_inv_num
  ti_inv_line_type
  ti_inv_line_total_vendor
  ti_fiscal_cycle
  ti_vendor_alpha_id
  to_order_id
  to_order_line_num
  to_ord_key
  to_order_line_control_type
  to_order_line_copies
  to_order_line_cre_date
  to_order_line_dollars_paid
  to_order_line_seg_type
  ts_date_mailed
  ol_selector
  ol_cat_key
  ol_call_seq
  ds_hold_code
  d2_hldc_lib
  d2_hldc_loc
  d2_hldc_type
  sc_lib
  sc_id
  sc_cat1
  sc_cat2
  or_create_date
  ca_title
  ca_author
  ca_year
  ca_place
  ca_lang
  ca_pub260
  cn_callnum
  vn_name_key
  fn_name_key
  fn_level1
  fn_level2
  fn_level3
  fn_level4
  fn_fund_key
  fg_funding_key
  fg_fundcyc_key
  ca_fmt
  ca_020
  ca_022
  ca_024
  ca_series
  ca_962
  cn_shlv_key
  ol_volume
  i_created_by
  i_modified_by
)
csv_text = File.read(Rails.root.join('spec/fixtures/files/expenditures.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
Expenditures.create(hash)

ExpendituresFyDate.destroy_all
keys = %w(fy min_paydate max_paydate)
csv_text = File.read(Rails.root.join('spec/fixtures/files/expenditures_fy_dates.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
ExpendituresFyDate.create(hash)
