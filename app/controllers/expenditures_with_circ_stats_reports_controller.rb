###
# Controller to handle the Encumberances Report
###
class ExpendituresWithCircStatsReportsController < ApplicationController
  load_and_authorize_resource param_method: :batch_params

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:error] = 'There are no records for the specified date range'
    render action: 'new'
  end

  def new
    @expenditures_with_circ_stats_report = ExpendituresWithCircStatsReport.new
  end

  def create
    @expenditures_with_circ_stats_report = ExpendituresWithCircStatsReport.new(batch_params)
    if @expenditures_with_circ_stats_report.save
      flash[:success] = 'Report requested!'
      @expenditures_with_circ_stats_report.kickoff
      redirect_to root_path
    else
      flash[:warning] = 'Check that all form fields are entered!'
      render action: 'new'
    end
  end

  def batch_params
    params.require(:expenditures_with_circ_stats_report).permit!
  end
end
