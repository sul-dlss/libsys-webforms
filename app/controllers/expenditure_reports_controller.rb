###
# Controller to handle the Encumberances Report
###
class ExpenditureReportsController < ApplicationController
  def new
    @expenditure_report = ExpenditureReport.new
  end

  def create
    @expenditure_report = ExpenditureReport.new(batch_params)
    if @expenditure_report.save
      flash[:success] = 'Report requested!'
    else
      flash[:warning] = 'Check that all form fields are entered!'
    end
    redirect_to root_path
  end

  def batch_params
    params.require(:expenditure_report).permit!
  end
end
