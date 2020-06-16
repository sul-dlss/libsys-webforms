###
# Controller to handle the Encumberances Report
###
class EncumbranceReportsController < ApplicationController
  load_and_authorize_resource param_method: :batch_params

  before_action :set_no_cache

  rescue_from ActiveRecord::RecordNotFound do
    flash[:error] = 'There are no records for the specified date range'
    render action: 'new'
  end

  def new
    @encumbrance_report = EncumbranceReport.new
  end

  def create
    @encumbrance_report = EncumbranceReport.new(batch_params)
    if @encumbrance_report.save
      flash[:success] = 'Report requested!'
      @encumbrance_report.kickoff
      redirect_to root_path
    else
      flash[:warning] = 'Check that all form fields are entered!'
      render action: 'new'
    end
  end

  def batch_params
    params.require(:encumbrance_report).permit!
  end
end
