###
# Controller to handle the Encumberances Report
###
class EndowedFundsReportsController < ApplicationController
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
      keys = catalog_keys
      # write keys to file to Symphony mount [/symphony] on libsys-webforms-dev
      if keys.any?
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

  def catalog_keys
    if @endowed_funds_report.fund
      catalog_keys = EndowedFundsReport.ol_cat_key_fund(@endowed_funds_report.fund, date_start, date_end)
    elsif @endowed_funds_report.fund_begin
      catalog_keys = EndowedFundsReport.ol_cat_key_fund_begin(@endowed_funds_report.fund_begin, date_start, date_end)
    end
    catalog_keys
  end

  def date_start
    if @endowed_funds_report.fiscal_years.any?
      start_date = Time.zone.parse("#{@endowed_funds_report.fiscal_years[0]}-09-01") - 1.year
    elsif @endowed_funds_report.calendar_years.any?
      start_date = Time.zone.parse("#{@endowed_funds_report.calendar_years[0]}-01-01")
    elsif @endowed_funds_report.paid_years.any?
      start_date = Time.zone.parse(@endowed_funds_report.paid_years[0].to_s)
    end
    start_date.strftime('%Y-%m-%d')
  end

  def date_end
    if @endowed_funds_report.fiscal_years.any?
      end_date = Time.zone.parse("#{@endowed_funds_report.fiscal_years[1]}-08-31")
    elsif @endowed_funds_report.calendar_years.any?
      end_date = Time.zone.parse("#{@endowed_funds_report.calendar_years[1]}-12-31")
    elsif @endowed_funds_report.paid_years.any?
      end_date = Time.zone.parse(@endowed_funds_report.paid_years[1].to_s)
    end
    end_date.strftime('%Y-%m-%d')
  end

  def batch_params
    params.require(:endowed_funds_report).permit!
  end
end
