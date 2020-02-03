require 'rails_helper'

RSpec.describe 'lobbytrack_reports/visit_dates.html.erb', type: :view do
  let(:lobbytrack_report_results) do
    [
      { 'CardHolderID' => '007',
        'DateIn' => Date.parse('2018-08-31 09:19:39'),
        'ReportField1' => 'JAMES',
        'ReportField2' => 'BOND',
        'LookupField1' => 'jbond@mi6.org' },
      { 'CardHolderID' => '009',
        'DateIn' => Date.parse('2018-09-13 15:05:56'),
        'ReportField1' => 'ALEC',
        'ReportField2' => 'TREVELYAN',
        'LookupField1' => 'atrevelyan@spectre.org' }
    ]
  end

  before do
    assign(:lobbytrack_reports, lobbytrack_report_results)
    render
  end

  describe 'visits result page' do
    it 'displays a header with some info about the report' do
      assert_select 'h1', text: 'Visits within a date range:', count: 1
      assert_select 'h2', text: '2 Visits', count: 1
    end

    it 'displays buttons to link back to the menus' do
      assert_select 'button', text: 'Main menu', count: 2
      assert_select 'button', text: 'LobbyTrack reports', count: 2
    end

    it 'displays a table header with column names' do
      assert_select 'table.table-striped', count: 1
      assert_select 'th', text: 'Cardholder ID', count: 1
      assert_select 'th', text: 'Visit date', count: 1
      assert_select 'th', text: 'First name', count: 1
      assert_select 'th', text: 'Last name', count: 1
      assert_select 'th', text: 'Email address', count: 1
    end

    it 'displays a table with some report results' do
      assert_select 'td', text: '007', count: 1
      assert_select 'a', text: '007', count: 1
      assert_select 'td', text: '2018-08-31 00:00', count: 1
      assert_select 'td', text: 'BOND', count: 1
      assert_select 'td', text: 'JAMES', count: 1
      assert_select 'td', text: 'jbond@mi6.org', count: 1
    end

    it 'displays a table with more report results' do
      assert_select 'td', text: '009', count: 1
      assert_select 'a', text: '009', count: 1
      assert_select 'td', text: '2018-09-13 00:00', count: 1
      assert_select 'td', text: 'TREVELYAN', count: 1
      assert_select 'td', text: 'ALEC', count: 1
      assert_select 'td', text: 'atrevelyan@spectre.org', count: 1
    end
  end
end
