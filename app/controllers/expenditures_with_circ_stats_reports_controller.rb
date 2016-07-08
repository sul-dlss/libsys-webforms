###
# Controller to handle the Encumberances Report
###
class ExpendituresWithCircStatsReportsController < ApplicationController
  def new
    @expenditures_with_circ_stats_report = ExpendituresWithCircStatsReport.new
  end

  def create
    @expenditures_with_circ_stats_report = ExpendituresWithCircStatsReport.new(batch_params)
    if @expenditures_with_circ_stats_report.save
      flash[:success] = 'Report requested!'
    else
      flash[:warning] = 'Check that all form fields are entered!'
    end
    redirect_to root_path
  end

  def batch_params
    params.require(:expenditures_with_circ_stats_report).permit!
  end
end
