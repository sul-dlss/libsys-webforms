# Class to connect to Lobbytrack
class LobbytrackReport
  include ActiveModel::Model
  require 'tiny_tds'

  attr_accessor :visit_id, :checkin_id, :visit_date1, :visit_date2, :checkin_date1, :checkin_date2

  validates :visit_id, length: { is: 7 }, numericality: true, allow_blank: true
  validates :checkin_id, length: { is: 7 }, numericality: true, allow_blank: true
  validates :visit_date1, format: { with: /[0-9]{4}-[0-9]{2}-[0-9]{2}/ }, allow_blank: true
  validates :visit_date2, format: { with: /[0-9]{4}-[0-9]{2}-[0-9]{2}/ }, allow_blank: true
  validates :checkin_date1, format: { with: /[0-9]{4}-[0-9]{2}-[0-9]{2}/ }, allow_blank: true
  validates :checkin_date2, format: { with: /[0-9]{4}-[0-9]{2}-[0-9]{2}/ }, allow_blank: true

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

  def self.query_visitor(id)
    result = client.active? ? client.execute(visitor_data(id)).each : client.close
    query_error = TinyTds::Error.new('Visitor ID not found')
    raise query_error unless result.any?

    result
  end

  def self.visits(id)
    'DECLARE @id VARCHAR(7)' \
    " SET @id = '#{id}'" \
    ' SELECT DateIn' \
    ' FROM Jolly.dbo.logAttendance' \
    ' WHERE CardHolderID = @id'
  end

  def self.visits_for_dates(date1, date2)
    'DECLARE @date1 date' \
    ' DECLARE @date2 date' \
    " SET @date1 = '#{date1} 00:00:00'" \
    " SET @date2 = '#{date2} 23:59:59'" \
    ' SELECT CardHolderID, DateIn, ReportField1, ReportField2, LookupField1' \
    ' FROM Jolly.dbo.logAttendance' \
    ' WHERE DateIn between @date1 and @date2'
  end

  def self.checkins(id)
    'DECLARE @id VARCHAR(7)' \
    " SET @id = '#{id}'" \
    ' SELECT DateOfEvent, LocationID' \
    ' FROM Jolly.dbo.logPerson' \
    ' WHERE CardHolderID = @id'
  end

  def self.checkins_for_dates(date1, date2)
    'DECLARE @date1 date' \
    ' DECLARE @date2 date' \
    " SET @date1 = '#{date1} 00:00:00'" \
    " SET @date2 = '#{date2} 23:59:59'" \
    ' SELECT CardHolderID, DateOfEvent, LocationID, ReportField1, ReportField2, LookupField1' \
    ' FROM Jolly.dbo.logPerson' \
    ' WHERE DateOfEvent between @date1 and @date2'
  end

  def self.visitor_data(id)
    'DECLARE @id VARCHAR(7)' \
    " SET @id = '#{id}'" \
    ' SELECT IDNumber, FirstName, LastName, PhoneNumber, Email, StreetAddress, City, State, PostalCode, Photo' \
    ' FROM GroupTables.dbo.Visitor' \
    ' WHERE IDNumber = @id'
  end

  def self.visitor_hash(data)
    visitor = data.first
    {
      'IDNumber' => visitor['IDNumber'] || '',
      'FirstName' => visitor['FirstName'] || '',
      'LastName' => visitor['LastName'] || '',
      'PhoneNumber' => visitor['PhoneNumber'] || '',
      'Email' => visitor['Email'] || '',
      'StreetAddress' => visitor['StreetAddress'] || '',
      'City' => visitor['City'] || '',
      'State' => visitor['State'] || '',
      'PostalCode' => visitor['PostalCode'] || ''
    }
  end

  def self.location
    {
      0 => '',
      1 => 'Green',
      4 => 'East Asia',
      5 => 'SAL1&2',
      6 => 'Art',
      13 => 'GreenSpec'
    }
  end
end
