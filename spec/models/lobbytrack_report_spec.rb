require 'rails_helper'

RSpec.describe LobbytrackReport, type: :model do
  describe 'sql query for visits' do
    it 'creates a querystring with the given lobbytrack id' do
      expect(described_class.visits('123')).to eq 'SELECT CardHolderID, DateIn' \
                                                          ', ReportField1, ReportField2, LookupField1' \
                                                          " FROM Jolly.dbo.logAttendance WHERE CardHolderID = '123'"
    end
  end

  describe 'sql query for visits_for_dates' do
    it 'creates a querystring with the given dates' do
      expect(described_class.visits_for_dates('01/01/2019', '01/01/2020')).to eq 'SELECT CardHolderID, DateIn' \
                                                        ', ReportField1, ReportField2, LookupField1' \
                                                        ' FROM Jolly.dbo.logAttendance WHERE DateIn between' \
                                                        " '01/01/2019 00:00:00' and '01/01/2020 23:59:59'"
    end
  end

  describe 'sql query for checkins' do
    it 'creates a querystring with the given lobbytrack id' do
      expect(described_class.checkins('123')).to eq 'SELECT CardHolderID, DateOfEvent' \
                                                            ', ReportField1, ReportField2, LookupField1' \
                                                            " FROM Jolly.dbo.logPerson WHERE CardHolderID = '123'"
    end
  end

  describe 'sql query for checkins_for_dates' do
    it 'creates a querystring with the given dates' do
      expect(described_class.checkins_for_dates('01/01/2019', '01/01/2020')).to eq 'SELECT CardHolderID, DateOfEvent' \
                                                         ', ReportField1, ReportField2, LookupField1' \
                                                        ' FROM Jolly.dbo.logPerson WHERE DateOfEvent between' \
                                                        " '01/01/2019 00:00:00' and '01/01/2020 23:59:59'"
    end
  end
end
