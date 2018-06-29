require 'rails_helper'

RSpec.describe 'edi_error_reports/index', type: :view do
  context 'any user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:staff_user) }
      assign(:edi_error_report, [FactoryBot.create(:edi_error_report)])
      render
    end
    it 'should display the page header' do
      assert_select 'h1', text: 'EDIFACT invoice errors'.to_s
    end
    it 'should display an error line' do
      assert_select 'td', text: '02/02/18 14:05'.to_s
      assert_select 'td', text: /EDI_PROCESS_ORDER.do_inv_line_order:xcptn==stop_this_line ||===|| vendor==CASALI*/
      assert_select 'td', text: /failed step==firm:verify_po on err==supplied PO# not in Unicorn:CAS6729454 edi_ckey:*/
      assert_select 'td', text: 'notify'.to_s
    end
  end
end
