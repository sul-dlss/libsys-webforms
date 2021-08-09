require 'rails_helper'

RSpec.describe LobbytrackReport, type: :model do
  let(:default_sets) do
    'SET ANSI_DEFAULTS ON' \
      ' SET QUOTED_IDENTIFIER ON' \
      ' SET CURSOR_CLOSE_ON_COMMIT OFF' \
      ' SET IMPLICIT_TRANSACTIONS OFF' \
      ' SET TEXTSIZE 2147483647' \
      ' SET CONCAT_NULL_YIELDS_NULL ON'
  end

  describe 'sql query for visits' do
    it 'sets sql default' do
      expect(described_class.default_sets).to eq default_sets
    end

    it 'creates a querystring with the given lobbytrack id' do
      expect(described_class.visits('1234567'))
        .to eq "#{default_sets} DECLARE @id VARCHAR(7)" \
               " SET @id = '1234567' SELECT DateIn FROM Jolly.dbo.logAttendance WHERE CardHolderID = @id"
    end
  end

  describe 'sql query for visits_for_dates' do
    it 'creates a querystring with the given dates' do
      expect(described_class.visits_for_dates('01/01/2019', '01/01/2020'))
        .to eq "#{default_sets} DECLARE @date1 date" \
               " DECLARE @date2 date SET @date1 = '01/01/2019 00:00:00' SET @date2 = '01/01/2020 23:59:59'" \
               ' SELECT CardHolderID, DateIn, ReportField1, ReportField2, LookupField1' \
               ' FROM Jolly.dbo.logAttendance WHERE DateIn between @date1 and @date2' \
               " AND CardHolderID > ''"
    end
  end

  describe 'sql query for checkins' do
    it 'creates a querystring with the given lobbytrack id' do
      expect(described_class.checkins('1234567'))
        .to eq "#{default_sets} DECLARE @id VARCHAR(7)" \
               " SET @id = '1234567' SELECT DateOfEvent, LocationID FROM Jolly.dbo.logPerson WHERE CardHolderID = @id"
    end
  end

  describe 'sql query for checkins_for_dates' do
    it 'creates a querystring with the given dates' do
      expect(described_class.checkins_for_dates('01/01/2019', '01/01/2020'))
        .to eq "#{default_sets}" \
               ' DECLARE @date1 date' \
               ' DECLARE @date2 date' \
               " SET @date1 = '01/01/2019 00:00:00' SET @date2 = '01/01/2020 23:59:59'" \
               ' SELECT CardHolderID, DateOfEvent, LocationID, ReportField1, ReportField2, LookupField1' \
               ' FROM Jolly.dbo.logPerson WHERE DateOfEvent between @date1 and @date2' \
               " AND CardHolderID > ''"
    end
  end

  describe 'sql query for visitor' do
    it 'creates a querystring for visitor info' do
      expect(described_class.visitor_data('1234567'))
        .to eq "#{default_sets} DECLARE @id VARCHAR(7)" \
               " SET @id = '1234567' SELECT IDNumber, FirstName, LastName, PhoneNumber, Email" \
               ', StreetAddress, City, State, PostalCode, Photo FROM GroupTables.dbo.Visitor WHERE IDNumber = @id'
    end
  end

  describe 'visitor data' do
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
          'PhoneNumber' => '7707007007'
        }
      ]
    end

    it 'maps the raw query data to a hash with empty strings if returned data is nil' do
      expect(described_class.visitor_hash(lobbytrack_visitor)).to include('IDNumber' => '007',
                                                                          'LastName' => 'BOND',
                                                                          'FirstName' => 'JAMES')
    end
  end

  describe 'location IDs' do
    it 'maps ID 0 to an empty location name' do
      expect(described_class.location.fetch(0)).to eq ''
    end

    it 'maps ID 1 to location name: Green' do
      expect(described_class.location.fetch(1)).to eq 'Green'
    end

    it 'maps ID 4 to location name: East Asia' do
      expect(described_class.location.fetch(4)).to eq 'East Asia'
    end

    it 'maps ID 5 to location name: SAL1&2' do
      expect(described_class.location.fetch(5)).to eq 'SAL1&2'
    end

    it 'maps ID 6 to location name: Art' do
      expect(described_class.location.fetch(6)).to eq 'Art'
    end

    it 'maps ID 13 to location name: GreenSpec' do
      expect(described_class.location.fetch(13)).to eq 'GreenSpec'
    end
  end
end
