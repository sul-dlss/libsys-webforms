# Controller for lobbytrack report
class LobbytrackReportsController < ApplicationController
  load_and_authorize_resource

  def index
    @lobbytrack_reports = LobbytrackReport.new
  end

  def visits
    id = params[:lobbytrack_report][:visit_id]
    begin
      @lobbytrack_reports = LobbytrackReport.query_visits(id)
    rescue TinyTds::Error => e
      flash[:error] = e
    end

    return if @lobbytrack_reports&.any?

    if Settings.lobbytrack_ips.include?(client_ip.to_s)
      flash[:error] = 'You cannot access Lobbytrack from the current client IP address'
    elsif id
      flash[:warning] = "There is no attendance history for id #{id}"
    end
    redirect_to lobbytrack_reports_path
  end

  def checkins
    id = params[:lobbytrack_report][:checkin_id]

    begin
      @lobbytrack_reports = LobbytrackReport.query_checkins(id)
    rescue TinyTds::Error => e
      flash[:error] = e
    end

    return if @lobbytrack_reports&.any?

    if Settings.lobbytrack_ips.include?(client_ip.to_s)
      flash[:error] = 'You cannot access Lobbytrack from the current client IP address'
    elsif id
      flash[:warning] = "There is no attendance history for id #{id}"
    end
    redirect_to lobbytrack_reports_path
  end

  def visit_dates
    date1 = params[:lobbytrack_report][:visit_date1]
    date2 = params[:lobbytrack_report][:visit_date2]
    @dates = "#{date1} to #{date2}"

    begin
      @lobbytrack_reports = LobbytrackReport.query_visit_dates(date1, date2)
    rescue TinyTds::Error => e
      flash[:error] = e
    end

    return if @lobbytrack_reports&.any?

    if Settings.lobbytrack_ips.include?(client_ip.to_s)
      flash[:error] = 'You cannot access Lobbytrack from the current client IP address'
    elsif @dates
      flash[:warning] = "There is no attendance history between the dates #{@dates}"
    end
    redirect_to lobbytrack_reports_path
  end

  def checkin_dates
    date1 = params[:lobbytrack_report][:checkin_date1]
    date2 = params[:lobbytrack_report][:checkin_date2]
    @dates = "#{date1} to #{date2}"

    begin
      @lobbytrack_reports = LobbytrackReport.query_checkin_dates(date1, date2)
    rescue TinyTds::Error => e
      flash[:error] = e
    end

    return if @lobbytrack_reports&.any?

    if Settings.lobbytrack_ips.include?(client_ip.to_s)
      flash[:error] = 'You cannot access Lobbytrack from the current client IP address'
    elsif @dates
      flash[:warning] = "There is no attendance history between the dates #{@dates}"
    end
    redirect_to lobbytrack_reports_path
  end
end
