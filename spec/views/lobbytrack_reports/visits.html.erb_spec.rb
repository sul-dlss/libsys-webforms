require 'rails_helper'

RSpec.describe 'lobbytrack_reports/visits.html.erb', type: :view do
  let(:lobbytrack_report_results) do
    [
      { 'CardHolderID' => '007',
        'DateIn' => Date.parse('2018-08-31 09:19:39') },
      { 'CardHolderID' => '007',
        'DateIn' => Date.parse('2018-09-13 15:05:56') }
    ]
  end

  let(:lobbytrack_visitor) do
    [
      {
        'IDNumber' => '007',
        'LastName' => 'BOND',
        'FirstName' => 'JAMES',
        'Email' => 'jbond@mi6.org',
        'StreetAddress' => 'SIS Building',
        'City' => 'London',
        'State' => 'England',
        'PostalCode' => '00707',
        'PhoneNumber' => '7707007007',
        'Photo' => nil
      }
    ]
  end

  before do
    assign(:lobbytrack_reports, lobbytrack_report_results)
    assign(:lobbytrack_visitor, lobbytrack_visitor)
    render
  end

  describe 'visits result page' do
    it 'displays a header with some info about the report' do
      assert_select 'h1', text: 'Visit report', count: 1
      assert_select 'p', text: 'ID: 007', count: 1
      assert_select 'p', text: 'Name: BOND, JAMES', count: 1
      assert_select 'p', text: 'Email: jbond@mi6.org', count: 1
      assert_select 'p', text: 'Address: SIS Building, London, England, 00707', count: 1
      assert_select 'p', text: 'Phone: 7707007007', count: 1
      assert_select 'div.photo', count: 1
      assert_select 'h3', text: '2 Visits', count: 1
    end

    it 'displays buttons to link back to the menus' do
      assert_select 'button', text: 'Main menu', count: 2
      assert_select 'button', text: 'LobbyTrack reports', count: 2
    end

    it 'displays a table with the report results' do
      assert_select 'table.table-striped', count: 1
      assert_select 'th', text: 'Visit count', count: 1
      assert_select 'th', text: 'Visit date', count: 1
      assert_select 'td', text: '1', count: 1
      assert_select 'td', text: '2018-08-31 00:00', count: 1
      assert_select 'td', text: '2018-09-13 00:00', count: 1
    end
  end
end
