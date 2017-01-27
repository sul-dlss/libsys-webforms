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
        catalog_keys = EndowedFundsReport.ol_cat_key(@endowed_funds_report.fund, date_start, date_end)
      elsif @endowed_funds_report.fund_begin
        catalog_keys = EndowedFundsReport.ol_cat_key(@endowed_funds_report.fund_begin, date_start, date_end)
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

  def date_start
    if @endowed_funds_report.fiscal_years.any?
      start_date = Time.zone.parse("#{@endowed_funds_report.fiscal_years[0]}-07-01")
    elsif @endowed_funds_report.calendar_years.any?
      start_date = Time.zone.parse("#{@endowed_funds_report.calendar_years[0]}-01-01")
    elsif @endowed_funds_report.paid_years.any?
      start_date = Time.zone.parse(@endowed_funds_report.paid_years[0].to_s)
    end
    start_date
  end

  def date_end
    if @endowed_funds_report.fiscal_years.any?
      end_date = Time.zone.parse("#{@endowed_funds_report.fiscal_years[1]}-06-30")
    elsif @endowed_funds_report.calendar_years.any?
      end_date = Time.zone.parse("#{@endowed_funds_report.calendar_years[1]}-12-31")
    elsif @endowed_funds_report.paid_years.any?
      end_date = Time.zone.parse(@endowed_funds_report.paid_years[1].to_s)
    end
    end_date
  end

  def batch_params
    params.require(:endowed_funds_report).permit!
  end
end
