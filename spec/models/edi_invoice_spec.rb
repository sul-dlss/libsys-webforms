require 'rails_helper'

RSpec.describe EdiInvoice, type: :model do
  let(:vendors) { %w(YANKEE COUTTS CASALI AMALIV HARRAS) }
  describe 'display of vendor lists' do
    it 'defines a set of unique vendors' do
      expect(EdiInvoice.edi_vend_id).to include(*vendors)
    end
    it 'defines the vendor filter for the table scope' do
      expect(EdiInvoice.vendor_filter).to include(*vendors.push('ALL'))
    end
  end
  describe 'make_updates' do
    it 'should insert a new exclude row into the  edi_invoice table if an exclude des not exist' do
      update = EdiInvoice.make_updates('AMALIV', '12345')
      expect(update[0].to_s).to eq 'warning'
      edi_invoice = EdiInvoice.find_by(edi_vend_id: 'AMALIV', edi_doc_num: '12345')
      expect(edi_invoice.edi_msg_id).to eq('Excld')
      expect(edi_invoice.edi_msg_typ).to eq('INVOIC')
      expect(edi_invoice.todo).to eq('Excld')
      expect(edi_invoice.edi_msg_seg).to eq('HDR')
    end
    it 'should return an error message if the invoice is already excluded' do
      update = []
      2.times do
        update = EdiInvoice.make_updates('AMALIV', '12345')
      end
      expect(update[0].to_s).to eq 'error'
    end
    it 'updates the edi_invoice table and deletes the edi_inv_line and edi_piece for an existing excludeable row' do
      update = EdiInvoice.make_updates('HARRAS', '150305')
      expect(update[0].to_s).to eq 'warning'

      inv_line = EdiInvLine.find_by(edi_doc_num: '150305', edi_vend_id: 'HARRAS')
      expect(inv_line).to be nil

      piece = EdiInvPiece.find_by(edi_doc_num: '150305', edi_vend_id: 'HARRAS')
      expect(piece).to be nil

      edi_invoice = EdiInvoice.find_by(edi_vend_id: 'HARRAS', edi_doc_num: '150305')
      expect(edi_invoice.todo).to eq('Excld')
      expect(edi_invoice.uni_vend_key).to eq(nil)
      expect(edi_invoice.uni_accrue_or_pay_tax).to eq(nil)
      expect(edi_invoice.edi_stanfd_account).to eq(nil)
      expect(edi_invoice.uni_inv_lib).to eq(nil)
      expect(edi_invoice.uni_inv_key).to eq(nil)
      expect(edi_invoice.uni_inv_num).to include('<-Excld')
      expect(edi_invoice.edi_invc_total).to eq(0)
      expect(edi_invoice.uni_invc_total).to eq(0)
      expect(edi_invoice.edi_total_postage).to eq(0)
      expect(edi_invoice.edi_total_freight).to eq(0)
      expect(edi_invoice.edi_total_handling).to eq(0)
      expect(edi_invoice.edi_total_insurance).to eq(0)
      expect(edi_invoice.edi_cur_code).to eq(nil)
      expect(edi_invoice.edi_total_tax).to eq(0)
      expect(edi_invoice.edi_exchg_rate).to eq(nil)
      expect(edi_invoice.edi_tax_rate).to eq(nil)
      expect(edi_invoice.edi_total_pieces).to eq(0)
    end
  end
end
