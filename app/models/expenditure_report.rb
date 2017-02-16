###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpenditureReport < ActiveRecord::Base
  attr_accessor :fund, :fund_begin, :fund_select, :date_request, :date_ran, :date_type,
                :fy_start, :fy_end, :cal_start, :cal_end, :pd_start, :pd_end, :output_file

  validates :email, presence: true
  validates :fund, presence: true, if: 'fund_begin.nil?'
  validates :fund_begin, presence: true, if: 'fund.nil?'
  validates :date_type, inclusion: %w(fiscal calendar paydate)

  before_save :set_fund, :write_dates, :set_output_file
  before_save :check_fy, if: 'date_type == "fiscal"'
  before_save :check_cal, if: 'date_type == "calendar"'
  before_save :check_pd, if: 'date_type == "paydate"'
  self.table_name = 'expenditures_log'

  def kickoff
    ActiveRecord::Base.connection.execute("begin expend_rpt.run_rpt('#{output_file}'); end;")
  rescue ActiveRecord::StatementInvalid
  end

  private

  def set_fund
    if fund
      # the multi select collects an array
      # but ta_fund_code is a string
      self[:ta_fund_code] = fund.join(',')
    elsif fund_begin
      self[:ta_fund_code] = fund_begin
    end
  end

  def check_fy
    if fy_start.present? && fy_end.present?
      write_fy_start(fy_start.sub('FY', ''))
      write_fy_end(fy_end.sub('FY', ''))
    else # fy_end is the same as fy_start
      write_fy_start(fy_start.sub('FY', ''))
      write_fy_end(fy_start.sub('FY', ''))
    end
  end

  def check_cal
    if cal_start.present? && cal_end.present?
      write_cal_start(cal_start)
      write_cal_end(cal_end)
    else # cal_end is the same as cal_start
      write_cal_start(cal_start)
      write_cal_end(cal_start)
    end
  end

  def check_pd
    if pd_start.present? && pd_end.present?
      write_pd_start(pd_start)
      write_pd_end(pd_end)
    else # pd_end is the same as pd_start
      write_pd_start(pd_start)
      write_pd_end(pd_start)
    end
  end

  def write_fy_start(year)
    fy_start = ExpendituresFyDate.find(year).min_paydate.strftime('%Y-%^b-%d')
    write_range_start(fy_start)
  end

  def write_fy_end(year)
    fy_end = ExpendituresFyDate.find(year).max_paydate.strftime('%Y-%^b-%d')
    write_range_end(fy_end)
  end

  def write_cal_start(year)
    cal_start = Time.zone.parse("#{year}-01-01").strftime('%Y-%m-%d')
    write_range_start(cal_start)
  end

  def write_cal_end(year)
    cal_end = Time.zone.parse("#{year}-12-31").strftime('%Y-%m-%d')
    write_range_end(cal_end)
  end

  def write_pd_start(date)
    pd_start = Time.zone.parse(date).strftime('%Y-%^b-%d')
    write_range_start(pd_start)
  end

  def write_pd_end(date)
    pd_end = Time.zone.parse(date).strftime('%Y-%^b-%d')
    write_range_end(pd_end)
  end

  def write_range_start(date)
    self[:date_range_start] = date
  end

  def write_range_end(date)
    self[:date_range_end] = date
  end

  def write_dates
    self[:date_request] = Time.zone.now
    self[:date_ran] = nil
  end

  def set_output_file
    self[:output_file] = output_file
  end
end
