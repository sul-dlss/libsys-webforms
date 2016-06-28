###
#  Controller to handle the Circulation Statistics Report
###
class CirculationStatisticsReportsController < ApplicationController
  def new
    @circulation_statistics_report = CirculationStatisticsReport.new
  end
end
