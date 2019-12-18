# Class to connect to Lobbytrack
class LobbytrackReport
  include ActiveModel::Model

  attr_accessor :visit_id, :checkin_id, :visit_date1, :visit_date2, :checkin_date1, :checkin_date2
  require 'tiny_tds'

  def self.client
    TinyTds::Client.new username: Settings.lobbytrack_user, password: Settings.lobbytrack_password,
                        host: Settings.lobbytrack_host, port: Settings.lobbytrack_port,
                        database: Settings.lobbytrack_db, login_timeout: 5
  end

  def self.query_visits(visit_id)
    client.active? ? client.execute(visits(visit_id)).each : client.close
  end

  def self.query_visit_dates(date1, date2)
    client.active? ? client.execute(visits_for_dates(date1, date2)).each : client.close
  end

  def self.query_checkins(visit_id)
    client.active? ? client.execute(checkins(visit_id)).each : client.close
  end

  def self.query_checkin_dates(date1, date2)
    client.active? ? client.execute(checkins_for_dates(date1, date2)).each : client.close
  end

  def self.visits(id)
    'SELECT CardHolderID, DateIn, ReportField1, ReportField2, LookupField1' \
    ' FROM Jolly.dbo.logAttendance' \
    " WHERE CardHolderID = '#{id}'"
  end

  def self.visits_for_dates(date1, date2)
    'SELECT CardHolderID, DateIn, ReportField1, ReportField2, LookupField1' \
    ' FROM Jolly.dbo.logAttendance' \
    " WHERE DateIn between '#{date1} 00:00:00' and '#{date2} 23:59:59'"
  end

  def self.checkins(id)
    'SELECT CardHolderID, DateOfEvent, ReportField1, ReportField2, LookupField1' \
    ' FROM Jolly.dbo.logPerson' \
    " WHERE CardHolderID = '#{id}'"
  end

  def self.checkins_for_dates(date1, date2)
    'SELECT CardHolderID, DateOfEvent, ReportField1, ReportField2, LookupField1' \
    ' FROM Jolly.dbo.logPerson' \
    " WHERE DateOfEvent between '#{date1} 00:00:00' and '#{date2} 23:59:59'"
  end
end
