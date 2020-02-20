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

  rescue_from ActiveRecord::RecordNotFound do |exception|
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
      if keys.present?
        @endowed_funds_report.write_keys(keys)
        flash[:success] = 'Report requested!'
        redirect_to root_path
      else
        flash[:error] = 'Could not find catalog keys for the date range selected'
        render action: 'new'
      end
    else
      flash[:warning] = 'Check that all form fields are entered!'
      render action: 'new'
    end
  end

  def keys
    if !@endowed_funds_report.fund.nil?
      @endowed_funds_report.fiscal_years.any? ? funds_fy : funds_keys
    elsif !@endowed_funds_report.fund_begin.nil?
      @endowed_funds_report.fiscal_years.any? ? funds_fy_begin : funds_keys_begin
    end
  end

  def funds_keys
    EndowedFundsReport.ol_cat_key_fund(@endowed_funds_report.fund, date_start, date_end)
  end

  def funds_fy
    EndowedFundsReport.ol_cat_key_fy(@endowed_funds_report.fund, date_start, date_end)
  end

  def funds_keys_begin
    EndowedFundsReport.ol_cat_key_fund_begin(@endowed_funds_report.fund, date_start, date_end)
  end

  def funds_fy_begin
    EndowedFundsReport.ol_cat_key_fy_begin(@endowed_funds_report.fund, date_start, date_end)
  end

  def date_start
    if @endowed_funds_report.fiscal_years.any?
      start_date = @endowed_funds_report.fiscal_years[0]
    elsif @endowed_funds_report.calendar_years.any?
      start_date = Time.parse("#{@endowed_funds_report.calendar_years[0]}-01-01").in_time_zone.strftime('%Y-%m-%d')
    elsif @endowed_funds_report.paid_years.any?
      start_date = Time.parse(@endowed_funds_report.paid_years[0].to_s).in_time_zone.strftime('%Y-%m-%d')
    end
    start_date
  end

  def date_end
    if @endowed_funds_report.fiscal_years.any?
      end_date = @endowed_funds_report.fiscal_years[1]
    elsif @endowed_funds_report.calendar_years.any?
      end_date = Time.parse("#{@endowed_funds_report.calendar_years[1]}-12-31").in_time_zone.strftime('%Y-%m-%d')
    elsif @endowed_funds_report.paid_years.any?
      end_date = Time.parse(@endowed_funds_report.paid_years[1].to_s).in_time_zone.strftime('%Y-%m-%d')
    end
    end_date
  end

  def batch_params
    params.require(:endowed_funds_report).permit!
  end
end
