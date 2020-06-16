###
# Controller to handle the Encumberances Report
###
class EndowedFundsReportsController < ApplicationController
  load_and_authorize_resource param_method: :batch_params

  include SymphonyCgi
  before_action :set_no_cache

  after_action only: :create do
    submit_endow_funds(batch_params)
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:error] = 'There are no records for the specified date range'
    render action: 'new'
  end

  def new
    @endowed_funds_report = EndowedFundsReport.new
  end

  def create
    @endowed_funds_report = EndowedFundsReport.new(batch_params)
    if @endowed_funds_report.valid?
      # write keys to file to Symphony mount [/symphony] on libsys-webforms-dev
      keys = @endowed_funds_report.keys
      if keys.present?
        out_file = File.new("#{Settings.symphony_dataload_endowrpt}/#{@endowed_funds_report.ckeys_file}", 'w')
        out_file.puts(keys.join("\n"))
        out_file.close
        flash[:success] = 'Report requested!'
        redirect_to root_path
      else
        flash[:error] = 'Could not find catalog keys for the date range selected'
        render action: 'new'
      end
    else
      flash[:warning] = 'Check that all form fields are entered'
      render action: 'new'
    end
  end

  def batch_params
    params.require(:endowed_funds_report).permit!
  end
end
