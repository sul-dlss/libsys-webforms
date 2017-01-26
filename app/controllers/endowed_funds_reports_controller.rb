###
# Controller to handle the Encumberances Report
###
class EndowedFundsReportsController < ApplicationController
  include SymphonyCgi
  before_action :set_no_cache
  after_action only: :create do
    submit_endow_funds(batch_params)
  end

  def new
    @endowed_funds_report = EndowedFundsReport.new
  end

  def create
    @endowed_funds_report = EndowedFundsReport.new(batch_params)
    if @endowed_funds_report.valid?
      if @endowed_funds_report.fund
        catalog_keys = EndowedFundsReport.ol_cat_key(@endowed_funds_report.fund)
      elsif @endowed_funds_report.fund_begin
        catalog_keys = EndowedFundsReport.ol_cat_key(@endowed_funds_report.fund_begin)
      end
      # write keys to file to Symphony mount [/symphony] on libsys-webforms-dev
      @endowed_funds_report.write_keys(catalog_keys)
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
