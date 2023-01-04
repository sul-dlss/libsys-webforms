require 'rails_helper'

RSpec.describe EdiInvoice do
  Rails.application.load_seed
  let(:vendors) { %w(YANKEE COUTTS CASALI AMALIV HARRAS) }

  describe 'display of vendor lists' do
    it 'defines a set of unique vendors' do
      expect(described_class.edi_vend_id).to include(*vendors)
    end

    it 'defines the vendor filter for the table scope' do
      expect(described_class.vendor_filter).to include(*vendors.push('ALL'))
    end
  end

  # The order of the tests matters here
  # rubocop:disable RSpec/MultipleExpectations, RSpec/ExampleLength
  describe 'make_updates' do
    it 'shows an error if the invoice cannot be excluded' do
      update = described_class.make_updates('HARRAS', '150302')
      expect(update[0].to_s).to eq 'error'
    end

    it 'inserts a new exclude row into the edi_invoice table if an exclude does not exist' do
      update = described_class.make_updates('AMALIV', '12345')
      expect(update[0].to_s).to eq 'warning'
      edi_invoice = described_class.find_by(edi_vend_id: 'AMALIV', edi_doc_num: '12345')
      expect(edi_invoice.edi_msg_id).to eq('Excld')
      expect(edi_invoice.edi_msg_typ).to eq('INVOIC')
      expect(edi_invoice.todo).to eq('Excld')
      expect(edi_invoice.edi_msg_seg).to eq('HDR')
    end

    it 'updates invoices to be excluded if they are not past the point of exclusion' do
      update = []
      2.times do
        update = described_class.make_updates('AMALIV', '12345')
      end
      expect(update[0].to_s).to eq 'warning'
    end

    it 'updates the edi_invoice table and deletes the edi_inv_line and edi_piece for an existing excludeable row' do
      update = described_class.make_updates('HARRAS', '150305')
      expect(update[0].to_s).to eq 'warning'

      inv_line = EdiInvLine.find_by(edi_doc_num: '150305', edi_vend_id: 'HARRAS')
      expect(inv_line).to be_nil

      piece = EdiInvPiece.find_by(edi_doc_num: '150305', edi_vend_id: 'HARRAS')
      expect(piece).to be_nil

      edi_invoice = described_class.find_by(edi_vend_id: 'HARRAS', edi_doc_num: '150305')
      expect(edi_invoice.todo).to eq('Excld')
      expect(edi_invoice.uni_vend_key).to be_nil
      expect(edi_invoice.uni_accrue_or_pay_tax).to be_nil
      expect(edi_invoice.edi_stanfd_account).to be_nil
      expect(edi_invoice.uni_inv_lib).to be_nil
      expect(edi_invoice.uni_inv_key).to be_nil
      expect(edi_invoice.uni_inv_num).to include('<-Excld')
      expect(edi_invoice.edi_invc_total).to eq(0)
      expect(edi_invoice.uni_invc_total).to eq(0)
      expect(edi_invoice.edi_total_postage).to eq(0)
      expect(edi_invoice.edi_total_freight).to eq(0)
      expect(edi_invoice.edi_total_handling).to eq(0)
      expect(edi_invoice.edi_total_insurance).to eq(0)
      expect(edi_invoice.edi_cur_code).to be_nil
      expect(edi_invoice.edi_total_tax).to eq(0)
      expect(edi_invoice.edi_exchg_rate).to be_nil
      expect(edi_invoice.edi_tax_rate).to be_nil
      expect(edi_invoice.edi_total_pieces).to eq(0)
    end
  end
  # rubocop:enable RSpec/MultipleExpectations, RSpec/ExampleLength
end
