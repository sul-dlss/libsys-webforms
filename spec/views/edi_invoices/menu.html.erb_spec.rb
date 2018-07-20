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
  end
  context 'authorized user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:authorized_user) }
      render
    end
    it 'should display the page header' do
      assert_select 'h3', text: 'What would you like to do?'.to_s
    end
    it 'should display the excluse invoice link' do
      assert_select 'a', text: 'Exclude an invoice'.to_s,
                         href: edi_invoices_invoice_exclude_path
    end
    it 'should display the change po link' do
      assert_select 'a', text: 'Change invoice line (PO num, fund name)'.to_s,
                         href: edi_invoices_change_invoice_line_path
    end
    it 'should display the allow nobiblink' do
      assert_select 'a', text: 'Allow a "noBib"'.to_s,
                         href: edi_lins_allow_nobib_path
    end
    it 'should display the fix duplicate barcode link' do
      assert_select 'a', text: 'Fix duplicate barcode'.to_s,
                         href: edi_invoices_fix_duplicate_barcode_path
    end
    it 'should display the View invoices link' do
      assert_select 'a', text: 'View invoices'.to_s,
                         href: edi_invoices_path
    end
    it 'should display the View errors link' do
      assert_select 'a', text: 'View errors'.to_s,
                         href: '/edi_error_reports'
    end
    it 'should display the fatal errors link' do
      assert_select 'a', text: 'Show only fatal errors'.to_s,
                         href: '/edi_error_reports?level=fatal'
    end
    it 'should display the notify errors link' do
      assert_select 'a', text: 'Show only notify errors'.to_s,
                         href: 'edi_error_reports?level=notify'
    end
    it 'should display the EDI_QUIT_ITEM.do_removes link' do
      assert_select 'a', text: "Show only 'EDI_QUIT_ITEM.do_removes'".to_s,
                         href: 'edi_error_reports?type=EDI_QUIT_ITEM.do_removes'
    end
  end
end
