require 'rails_helper'

RSpec.describe 'edi_invoices/index', type: :view do
  context 'any user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:blank_user) }
      @edi_invoice = EdiInvoice.all
      render
    end
    it 'should display the page header' do
      assert_select 'h1', text: 'EDIFACT invoice management'.to_s
    end
  end
end
