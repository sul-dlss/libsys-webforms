require 'rails_helper'

RSpec.describe 'edi_invoices/menu', type: :view do
  context 'any user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:blank_user) }
      render
    end
    it 'should display the page header' do
      assert_select 'h1', text: 'EDIFACT invoice management'.to_s
    end
  end
  context 'not an authorized user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:blank_user) }
      render
    end
    it 'should display a login link' do
      assert_select 'a', text: 'Please login'.to_s,
                         href: root_path
    end
  end
  context 'authorized user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:authorized_user) }
      render
    end
    it 'should display the page header' do
      assert_select 'h3', text: 'What would you like to do?'.to_s
    end
    it 'should display the page header' do
      assert_select 'a', text: 'Exclude an invoice'.to_s,
                         href: edi_invoices_invoice_exclude_path
    end
    it 'should display the page header' do
      assert_select 'a', text: 'Change invoice line (PO num, fund name)'.to_s,
                         href: edi_invoices_change_invoice_line_path
    end
    it 'should display the page header' do
      assert_select 'a', text: 'Allow a "noBib"'.to_s,
                         href: edi_invoices_allow_nobib_path
    end
    it 'should display the page header' do
      assert_select 'a', text: 'Fix duplicate barcode'.to_s,
                         href: edi_invoices_fix_duplicate_barcode_path
    end
    it 'should display the View invoices link' do
      assert_select 'a', text: 'View invoices'.to_s,
                         href: edi_invoices_path
    end
  end
end
