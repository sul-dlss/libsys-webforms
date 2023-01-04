require 'rails_helper'

RSpec.describe 'lobbytrack_reports/index.html.erb' do
  let(:lobbytrack_reports_params) do
    {
      visit_id: '007',
      checkin_id: '007',
      visit_date1: '01/01/2019',
      visit_date2: '01/01/2020',
      checkin_date1: '01/01/2019',
      checkin_date2: '01/01/2020'
    }
  end

  before do
    assign(:lobbytrack_reports, LobbytrackReport.new(lobbytrack_reports_params))
    render
  end

  describe 'report request form fields' do
    context 'when visit form fields' do
      it 'displays the visit count label' do
        assert_select 'label', text: 'Daily visits by cardholder id', count: 1
      end

      it 'displays the visit id input field' do
        assert_select 'input#lobbytrack_report_visit_id', count: 1
      end

      it 'displays the visit date range label' do
        assert_select 'label', text: 'Daily visits on a range of dates', count: 1
      end

      it 'displays the visit date1 input field' do
        assert_select 'input#lobbytrack_report_visit_date1', count: 1
      end

      it 'displays the visit date2 input field' do
        assert_select 'input#lobbytrack_report_visit_date2', count: 1
      end
    end

    context 'when checkin form fields' do
      it 'displays the checkins count label' do
        assert_select 'label', text: 'Daily check-ins by cardholder id', count: 1
      end

      it 'displays the checkin id input field' do
        assert_select 'input#lobbytrack_report_checkin_id', count: 1
      end

      it 'displays the checkin date range label' do
        assert_select 'label', text: 'Daily check-ins on a range of dates', count: 1
      end

      it 'displays the checkin date1 input field' do
        assert_select 'input#lobbytrack_report_checkin_date1', count: 1
      end

      it 'displays the checkin date2 input field' do
        assert_select 'input#lobbytrack_report_checkin_date2', count: 1
      end
    end

    it 'has four submit buttons' do
      assert_select 'input[value="Go"]', count: 4
    end

    it 'has a link back to the main menu' do
      assert_select 'button', text: 'Main menu', count: 1
    end
  end
end
