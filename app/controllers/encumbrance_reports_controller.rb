###
# Controller to handle the Encumberances Report
###
class EncumbranceReportsController < ApplicationController
  def new
    @encumbrance_report = EncumbranceReport.new
  end

  def create
    @encumbrance_report = EncumbranceReport.new(batch_params)
    if @encumbrance_report.save
      flash[:success] = 'Report requested!'
    else
      flash[:warning] = 'Check that all form fields are entered!'
    end
    redirect_to root_path
  end

  def batch_params
    params.require(:encumbrance_report).permit!
  end
end
