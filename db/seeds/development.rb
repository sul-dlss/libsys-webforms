require 'csv'

UnicornPolicy.destroy_all
keys = %w[type policy_num name description shadowed destination]
csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', 'unicorn_policies.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
UnicornPolicy.create(hash)

ExpendituresFunds.destroy_all
keys = %w[fund_id fund_name_key old_fund_id min_pay_date max_pay_date is_endow inv_lib]
csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', 'expenditures_funds.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
ExpendituresFunds.create(hash)

ExpendituresPaydates.destroy_all
keys = ['pay_date']
csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', 'expenditures_paydates.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
ExpendituresPaydates.create(hash)

UniLibsLocs.destroy_all
keys = %w[library home_loc]
csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', 'uni_libs_locs.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
UniLibsLocs.create(hash)

ShelfSelectionItemType.destroy_all
keys = ['item_type']
csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', 'item_types.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
ShelfSelectionItemType.create(hash)

ShelfSelItemCat1.destroy_all
keys = ['item_category1']
csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', 'item_cat1.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
ShelfSelItemCat1.create(hash)

CirculationStatisticsReportFormat.destroy_all
keys = ['format']
csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', 'formats.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
CirculationStatisticsReportFormat.create(hash)

Expenditures.destroy_all
keys = %w[ row_date review_date ta_inv_line_key ta_fund_code ta_fund_total_paid
   ta_gl_code ta_ord_line_key ta_inv_key ta_date_2encina ta_encina_key ta_invoice_total_withtax
  ta_tax_total ta_taxtype_flag ta_vend_inv_date ta_vend_inv_num ti_inv_lib ti_inv_line_note
  ti_inv_line_num ti_inv_line_total_us ti_unicorn_inv_num ti_inv_line_type ti_inv_line_total_vendor
  ti_fiscal_cycle ti_vendor_alpha_id to_order_id to_order_line_num to_ord_key to_order_line_control_type
  to_order_line_copies to_order_line_cre_date to_order_line_dollars_paid to_order_line_seg_type
  ts_date_mailed ol_selector ol_cat_key ol_call_seq ds_hold_code d2_hldc_lib d2_hldc_loc
  d2_hldc_type sc_lib sc_id sc_cat1 sc_cat2 or_create_date ca_title ca_author ca_year
  ca_place ca_lang ca_pub260 cn_callnum vn_name_key fn_name_key fn_level1 fn_level2
  fn_level3 fn_level4 fn_fund_key fg_funding_key fg_fundcyc_key ca_fmt ca_020 ca_022
  ca_024 ca_series ca_962 cn_shlv_key ol_volume i_created_by i_modified_by ]
csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', 'expenditures.csv'))
csv = CSV.parse(csv_text, headers: false)
csv.map { |a| Hash[keys.zip(a)] }
hash = csv.map { |a| Hash[keys.zip(a)] }
Expenditures.create(hash)

ExpendituresFyDate.destroy_all
dates = [
  ['9697', '04-OCT-1996', '08-AUG-1997'],
  ['9798', '12-SEP-1997', '28-AUG-1998'],
  ['9899', '11-SEP-1998', '27-AUG-1999'],
  ['2000', '10-SEP-1999', '01-SEP-2000'],
  ['2001', '08-SEP-2000', '31-AUG-2001'],
  ['2002', '07-SEP-2001', '30-AUG-2002'],
  ['2003', '06-SEP-2002', '29-AUG-2003'],
  ['2004', '05-SEP-2003', '27-AUG-2004'],
  ['2005', '03-SEP-2004', '26-AUG-2005'],
  ['2006', '02-SEP-2005', '30-AUG-2006'],
  ['2007', '08-SEP-2006', '30-AUG-2007'],
  ['2008', '07-SEP-2007', '28-AUG-2008'],
  ['2009', '05-SEP-2008', '27-AUG-2009'],
  ['2010', '04-SEP-2009', '26-AUG-2010'],
  ['2011', '03-SEP-2010', '25-AUG-2011'],
  ['2012', '02-SEP-2011', '24-AUG-2012'],
  ['2013', '31-AUG-2012', '23-AUG-2013'],
  ['2014', '30-AUG-2013', '11-OCT-2013'],
  ['2015', '04-DEC-2014', '29-JAN-2015'],
  ['2016', '04-DEC-2015', '29-JAN-2016'],
  ['2017', '04-DEC-2016', '29-JAN-2017']
]
dates.each do |fy, min, max|
  ExpendituresFyDate.create(fy: fy, min_paydate: min, max_paydate: max)
end
