###
# Controller to handle the Encumberances Report
###
class EndowedFundsReportsController < ApplicationController
  def new
    @endowed_funds_report = EndowedFundsReport.new
  end

  # 1_ count the number of funds and flash error if more than 50
  # 2_
  def create
    @endowed_funds_report = EndowedFundsReport.new(batch_params)
    if @endowed_funds_report.valid?
      flash[:success] = 'Report requested!'
      redirect_to root_path
    else
      flash[:warning] = 'Check that all form fields are entered!'
      render action: 'new'
    end
  end

  def batch_params
    params.require(:endowed_funds_report).permit!
  end
end
