# Class to connect to LobbyTraclk
class LobbyTrack
  include ActiveModel::Model

  require 'tiny_tds' if Settings.lobbytrack_ips.include?(ENV['HTTP_CLIENT_IP'].to_s)

  @client = TinyTds::Client.new username: Settings.lobbytrack_user, password: Settings.lobbytrack_password,
                                host: Settings.lobbytrack_host, port: Settings.lobbytrack_port,
                                database: Settings.lobbytrack_db

  def self.query(id)
    @client.active? ? @client.execute(sql(id)).each : @client.close
  end

  def self.sql(id)
    'SELECT CardHolderID, DateIn, ReportField1, ReportField2, LookupField1' \
    ' FROM Jolly.dbo.logAttendance' \
    " WHERE CardHolderID = '#{id}'"
  end
end
