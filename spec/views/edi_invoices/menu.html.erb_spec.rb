require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe 'edi_invoices/menu', type: :view do
  context 'when any user' do
    before do
      stub_current_user_for_view { create(:blank_user) }
      render
    end

    it 'displays the page header' do
      assert_select 'h1', text: 'EDIFACT invoice management'.to_s
    end
  end

  context 'without authorized user' do
    before do
      stub_current_user_for_view { create(:blank_user) }
      render
    end

    it 'displays the page header' do
      assert_select 'h3', text: 'What would you like to do?'
    end

    it 'displays the View invoices link' do
      assert_select 'a', text: 'View invoices',
                         href: edi_invoices_path
    end
  end

  context 'when authorized user' do
    before do
      stub_current_user_for_view { create(:authorized_user) }
      render
    end

    it 'displays the page header' do
      assert_select 'h3', text: 'What would you like to do?'
    end

    it 'does not displays the exclude invoice link' do
      assert_select 'a', text: 'Exclude an invoice',
                         href: edi_invoices_invoice_exclude_path
    end

    it 'displays the change po link' do
      assert_select 'a', text: 'Change invoice line (PO num, fund name)',
                         href: edi_invoices_change_invoice_line_path
    end

    it 'displays the allow nobiblink' do
      assert_select 'a', text: 'Allow a "noBib"',
                         href: edi_lins_allow_nobib_path
    end

    it 'displays the fix duplicate barcode link' do
      assert_select 'a', text: 'Fix duplicate barcode',
                         href: edi_lins_fix_duplicate_barcode_path
    end

    it 'displays the View invoices link' do
      assert_select 'a', text: 'View invoices',
                         href: edi_invoices_path
    end

    it 'displays the View errors link' do
      assert_select 'a', text: 'View errors',
                         href: '/edi_error_reports'
    end

    it 'displays the fatal errors link' do
      assert_select 'a', text: 'Show only fatal errors',
                         href: '/edi_error_reports?level=fatal'
    end

    it 'displays the notify errors link' do
      assert_select 'a', text: 'Show only notify errors',
                         href: 'edi_error_reports?level=notify'
    end

    it 'displays the EDI_QUIT_ITEM.do_removes link' do
      assert_select 'a', text: "Show only 'EDI_QUIT_ITEM.do_removes'",
                         href: 'edi_error_reports?type=EDI_QUIT_ITEM.do_removes'
    end
  end

  context 'when a staff user with read access' do
    before do
      stub_current_user_for_view { create(:staff_user) }
      render
    end

    it 'displays the page header' do
      assert_select 'h3', text: 'What would you like to do?'
    end

    it 'displays the exclude invoice link' do
      expect(rendered).not_to match 'Exclude an invoice'
    end

    it 'displays the change po link' do
      expect(rendered).not_to match 'Change invoice line (PO num, fund name)'
    end

    it 'displays the allow nobiblink' do
      expect(rendered).not_to match 'Allow a "noBib"'
    end

    it 'displays the fix duplicate barcode link' do
      expect(rendered).not_to match 'Fix duplicate barcode'
    end

    it 'displays the View invoices link' do
      assert_select 'a', text: 'View invoices',
                         href: edi_invoices_path
    end

    it 'displays the View errors link' do
      assert_select 'a', text: 'View errors',
                         href: '/edi_error_reports'
    end

    it 'displays the fatal errors link' do
      assert_select 'a', text: 'Show only fatal errors',
                         href: '/edi_error_reports?level=fatal'
    end

    it 'displays the notify errors link' do
      assert_select 'a', text: 'Show only notify errors',
                         href: 'edi_error_reports?level=notify'
    end

    it 'displays the EDI_QUIT_ITEM.do_removes link' do
      assert_select 'a', text: "Show only 'EDI_QUIT_ITEM.do_removes'",
                         href: 'edi_error_reports?type=EDI_QUIT_ITEM.do_removes'
    end
  end
end
# rubocop: enable Metrics/BlockLength
