require 'rails_helper'

RSpec.describe 'edi_error_reports/index', type: :view do
  context 'with any user' do
    before do
      stub_current_user_for_view { FactoryBot.create(:staff_user) }
      assign(:edi_error_report, [FactoryBot.create(:edi_error_report)])
      render
    end

    it 'displays the page header' do
      assert_select 'h1', text: 'EDIFACT invoice errors'.to_s
    end
    it 'displays an error line' do
      assert_select 'td', text: '2018-02-02 14:05'.to_s
      assert_select 'td', text: 'notify'.to_s
    end
  end

  context 'when error level scope' do
    before do
      stub_current_user_for_view { FactoryBot.create(:staff_user) }
      assign(:edi_error_report, [FactoryBot.create(:edi_error_report)])
    end

    it 'displays the page header with the EDI_QUIT_ITEM.do_removes type' do
      allow(controller).to receive(:params).and_return(type: 'EDI_QUIT_ITEM.do_removes')
      render
      assert_select 'h1', text: 'EDIFACT invoice errors (EDI_QUIT_ITEM.do_removes)'.to_s
    end
    it 'displays the page header with the fatal error level' do
      allow(controller).to receive(:params).and_return(level: 'fatal')
      render
      assert_select 'h1', text: 'EDIFACT invoice errors (fatal)'.to_s
    end
    it 'displays the page header with the notify error level' do
      allow(controller).to receive(:params).and_return(level: 'notify')
      render
      assert_select 'h1', text: 'EDIFACT invoice errors (notify)'.to_s
    end
  end
end
