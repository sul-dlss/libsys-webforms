require 'csv'

def make_table(model, file, keys)
  model.destroy_all
  csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', file))
  csv = CSV.parse(csv_text, headers: false)
  csv.map { |a| Hash[keys.zip(a)] }
  hash = csv.map { |a| Hash[keys.zip(a)] }
  model.create(hash)
end

make_table(EdiInvPiece, 'edi_inv_piece.csv', %w[edi_vend_id edi_doc_num])
make_table(EdiSumrzBib, 'edi_sumrz_bib.csv', %w[vend_code id001 edi_ckey load_date active_record])
make_table(EdiLin, 'edi_lin.csv', %w[doc_num vend_id edi_lin_num edi_sublin_count vend_unique_id])
make_table(EdiErrorReport, 'edi_error_report.csv', %w[run type error err_lvl])
make_table(EdiInvoice, 'edi_invoice.csv', %w[edi_doc_num edi_vend_id edi_vend_inv_date todo uni_inv_cre_date
  edi_total_pieces edi_msg_id edi_msg_typ edi_msg_seg uni_vend_key uni_accrue_or_pay_tax edi_stanfd_account uni_inv_lib
  uni_inv_key uni_inv_num edi_invc_total uni_invc_total edi_total_postage edi_total_freight edi_total_handling edi_total_insurance
  edi_cur_code edi_total_tax edi_exchg_rate edi_tax_rate edi_total_pieces])
make_table(EdiInvLine, 'edi_inv_line.csv', %w[tbl_row_num edi_vend_id edi_doc_num edi_line_num edi_fund edi_po_number edi_line_net edi_line_gross todo])
make_table(UnicornPolicy, 'unicorn_policies.csv', %w[type policy_num name description shadowed destination])
make_table(ExpendituresFunds, 'expenditures_funds.csv', %w[fund_id fund_name_key old_fund_id min_pay_date max_pay_date is_endow inv_lib])
make_table(ExpendituresPaydates, 'expenditures_paydates.csv', ['pay_date'])
make_table(UniLibsLocs, 'uni_libs_locs.csv', %w[library home_loc])
make_table(ShelfSelectionItemType, 'item_types.csv', ['item_type'])
make_table(ShelfSelItemCat1, 'item_cat1.csv', ['item_category1'])
make_table(CirculationStatisticsReportFormat, 'formats.csv', ['format'])
make_table(Expenditures, 'expenditures.csv', %w[row_date review_date ta_inv_line_key ta_fund_code ta_fund_total_paid
   ta_gl_code ta_ord_line_key ta_inv_key ta_date_2encina ta_encina_key ta_invoice_total_withtax
  ta_tax_total ta_taxtype_flag ta_vend_inv_date ta_vend_inv_num ti_inv_lib ti_inv_line_note
  ti_inv_line_num ti_inv_line_total_us ti_unicorn_inv_num ti_inv_line_type ti_inv_line_total_vendor
  ti_fiscal_cycle ti_vendor_alpha_id to_order_id to_order_line_num to_ord_key to_order_line_control_type
  to_order_line_copies to_order_line_cre_date to_order_line_dollars_paid to_order_line_seg_type
  ts_date_mailed ol_selector ol_cat_key ol_call_seq ds_hold_code d2_hldc_lib d2_hldc_loc
  d2_hldc_type sc_lib sc_id sc_cat1 sc_cat2 or_create_date ca_title ca_author ca_year
  ca_place ca_lang ca_pub260 cn_callnum vn_name_key fn_name_key fn_level1 fn_level2
  fn_level3 fn_level4 fn_fund_key fg_funding_key fg_fundcyc_key ca_fmt ca_020 ca_022
  ca_024 ca_series ca_962 cn_shlv_key ol_volume i_created_by i_modified_by ])

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

