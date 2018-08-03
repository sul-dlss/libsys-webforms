# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

def make_table(model, file, keys)
  model.destroy_all
  csv_text = File.read(Rails.root.join('spec', 'fixtures', 'files', file))
  csv = CSV.parse(csv_text, headers: false)
  csv.map { |a| Hash[keys.zip(a)] }
  hash = csv.map { |a| Hash[keys.zip(a)] }
  model.create(hash)
end

make_table(EdiSumrzBib, 'edi_sumrz_bib.csv', %w[vend_code id001 edi_ckey load_date active_record])
make_table(EdiLin, 'edi_lin.csv', %w[doc_num vend_id edi_lin_num edi_sublin_count vend_unique_id])
make_table(EdiInvPiece, 'edi_inv_piece.csv', %w[edi_vend_id edi_doc_num])
make_table(EdiInvoice, 'edi_invoice.csv', %w[edi_doc_num edi_vend_id edi_vend_inv_date todo uni_inv_cre_date
  edi_total_pieces edi_msg_id edi_msg_typ edi_msg_seg uni_vend_key uni_accrue_or_pay_tax edi_stanfd_account uni_inv_lib
  uni_inv_key uni_inv_num edi_invc_total uni_invc_total edi_total_postage edi_total_freight edi_total_handling edi_total_insurance
  edi_cur_code edi_total_tax edi_exchg_rate edi_tax_rate edi_total_pieces])

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
