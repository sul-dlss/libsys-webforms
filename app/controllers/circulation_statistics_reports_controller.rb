###
#  Controller to handle the Circulation Statistics Report
###
class CirculationStatisticsReportsController < ApplicationController
  def new
    @circulation_statistics_report = CirculationStatisticsReport.new
  end

  def create
    @circulation_statistics_report = CirculationStatisticsReport.new(params[:circulation_statistics_report])
    flash[:notice] = 'Circulation Statistics Report params submitted!'
    redirect_to root_url
  end

  def home_locations
    @home_locations = UniLibsLocs.home_locations_from(params[:lib])
    render layout: false
  end
end
