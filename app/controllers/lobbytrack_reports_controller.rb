# Controller for lobbytrack report
class LobbytrackReportsController < ApplicationController
  load_and_authorize_resource

  def index
    @lobbytrack_reports = LobbytrackReport.new
  end

  def visits
    id = params[:lobbytrack_report][:visit_id]

    @lobbytrack_form = LobbytrackReport.new(visit_id: id)
    if @lobbytrack_form.valid?
      begin
        @lobbytrack_visitor = LobbytrackReport.query_visitor(id)
        @lobbytrack_reports = LobbytrackReport.query_visits(id)
      rescue TinyTds::Error => e
        flash[:error] = e
      end
    else
      flash[:error] = 'Invalid ID entered.'
    end

    return if @lobbytrack_reports&.any?

    flash[:warning] = "There is no attendance history for id #{id}"
    redirect_to lobbytrack_reports_path
  end

  def checkins
    id = params[:lobbytrack_report][:checkin_id]

    @lobbytrack_form = LobbytrackReport.new(visit_id: id)
    if @lobbytrack_form.valid?
      begin
        @lobbytrack_visitor = LobbytrackReport.query_visitor(id)
        @lobbytrack_reports = LobbytrackReport.query_checkins(id)
      rescue TinyTds::Error => e
        flash[:error] = e
      end
    else
      flash[:error] = 'Invalid ID entered.'
    end

    return if @lobbytrack_reports&.any?

    flash[:warning] = "There is no attendance history for id #{id}"
    redirect_to lobbytrack_reports_path
  end

  def visit_dates
    date1 = params[:lobbytrack_report][:visit_date1]
    date2 = params[:lobbytrack_report][:visit_date2]
    @dates = "#{date1} to #{date2}"

    @lobbytrack_form = LobbytrackReport.new(visit_date1: date1, visit_date2: date2)
    if @lobbytrack_form.valid?
      begin
        @lobbytrack_reports = LobbytrackReport.query_visit_dates(date1, date2)
      rescue TinyTds::Error => e
        flash[:error] = e
      end
    else
      flash[:error] = 'Invalid date entered.'
    end

    return if @lobbytrack_reports&.any?

    flash[:warning] = "There is no attendance history between the dates #{@dates}"
    redirect_to lobbytrack_reports_path
  end

  def checkin_dates
    date1 = params[:lobbytrack_report][:checkin_date1]
    date2 = params[:lobbytrack_report][:checkin_date2]
    @dates = "#{date1} to #{date2}"

    @lobbytrack_form = LobbytrackReport.new(checkin_date1: date1, checkin_date2: date2)
    if @lobbytrack_form.valid?
      begin
        @lobbytrack_reports = LobbytrackReport.query_checkin_dates(date1, date2)
      rescue TinyTds::Error => e
        flash[:error] = e
      end
    else
      flash[:error] = 'Invalid date entered.'
    end

    return if @lobbytrack_reports&.any?

    flash[:warning] = "There is no attendance history between the dates #{@dates}"
    redirect_to lobbytrack_reports_path
  end
end
