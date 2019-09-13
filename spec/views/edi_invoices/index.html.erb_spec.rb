require 'rails_helper'

RSpec.describe 'edi_invoices/index', type: :view do
  before do
    assign(:edi_invoice, [FactoryBot.create(:edi_invoice)])
  end

  context 'with any user' do
    before do
      stub_current_user_for_view { FactoryBot.create(:staff_user) }
      render
    end

    it 'displays the page header' do
      assert_select 'h1', text: 'EDIFACT invoices'.to_s
    end
    it 'displays an invoice line' do
      assert_select 'td', text: 'I-10235828'.to_s
      assert_select 'td', text: 'COUTTS'.to_s
      assert_select 'td', text: '07/23/13'.to_s
      assert_select 'td', text: 'Rdy2Rcv'.to_s
      assert_select 'td', text: '07/23/13'.to_s
      assert_select 'td', text: '1'.to_s
    end
  end
end
