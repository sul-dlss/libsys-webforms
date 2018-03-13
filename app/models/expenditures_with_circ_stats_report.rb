###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpendituresWithCircStatsReport < ActiveRecord::Base
  attr_accessor :fund, :fund_begin, :fund_select, :date_request, :date_type,
                :fy_start, :fy_end, :cal_start, :cal_end, :pd_start, :pd_end,
                :lib_array, :libraries, :format_array, :formats

  validates :fund, presence: true, if: 'fund_begin.nil?'
  validates :fund_begin, presence: true, if: 'fund.nil?'
  validates :lib_array, presence: true
  validates :format_array, presence: true
  validates :date_type, inclusion: %w[fiscal calendar paydate]

  before_save :set_fund, :write_dates, :write_lib, :write_fmt
  before_save :check_fy, if: 'date_type == "fiscal"'
  before_save :check_cal, if: 'date_type == "calendar"'
  before_save :check_pd, if: 'date_type == "paydate"'

  self.table_name = 'expenditures_circ_log'

  private

  def set_fund
    if fund
      self[:ta_fund_code] = fund.join(',')
    elsif fund_begin
      self[:ta_fund_code] = fund_begin
    end
  end

  def write_lib
    self[:libraries] = lib_array.delete_if { |a| a == '' || a == 'All Libraries' }.join(',')
  end

  def write_fmt
    self[:formats] = format_array.delete_if { |a| a == '' || a == 'All Formats' }.join(',')
  end

  def check_fy
    write_fy_start(fy_start.sub('FY', ''))
    if fy_end.present?
      write_fy_end(fy_end.sub('FY', ''))
    else # fy_end is the same as fy_start
      write_fy_end(fy_start.sub('FY', ''))
    end
  end

  def check_cal
    write_cal_start(cal_start)
    if cal_end.present?
      write_cal_end(cal_end)
    else # cal_end is the same as cal_start
      write_cal_end(cal_start)
    end
  end

  def check_pd
    write_pd_start(pd_start)
    if pd_end.present?
      write_pd_end(pd_end)
    else # pd_end is the same as pd_start
      write_pd_end(pd_start)
    end
  end

  def write_fy_start(year)
    begin
      fy_start = ExpendituresFyDate.find(year).min_paydate.strftime('%Y-%^b-%d')
    rescue ActiveRecord::RecordNotFound => error
      raise error
    end
    write_range_start(fy_start)
  end

  def write_fy_end(year)
    begin
      fy_end = ExpendituresFyDate.find(year).max_paydate.strftime('%Y-%^b-%d')
    rescue ActiveRecord::RecordNotFound => error
      raise error
    end
    write_range_end(fy_end)
  end

  def write_cal_start(year)
    cal_start = Time.parse("#{year}-01-01").strftime('%Y-%m-%d')
    write_range_start(cal_start)
  end

  def write_cal_end(year)
    cal_end = Time.parse("#{year}-12-31").strftime('%Y-%m-%d')
    write_range_end(cal_end)
  end

  def write_pd_start(date)
    pd_start = Time.parse(date).strftime('%Y-%m-%d')
    write_range_start(pd_start)
  end

  def write_pd_end(date)
    pd_end = Time.parse(date).strftime('%Y-%m-%d')
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
  end
end
