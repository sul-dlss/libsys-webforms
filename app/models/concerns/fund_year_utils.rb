###
# Utilities to chose and/or transform the date range that gets persisted by Expenditure reports
###
module FundYearUtils
  extend ActiveSupport::Concern

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
      fy_val = ExpendituresFyDate.find(year).min_paydate.strftime('%Y-%^b-%d')
    rescue ActiveRecord::RecordNotFound => e
      raise e
    end
    write_range_start(fy_val)
  end

  def write_fy_end(year)
    begin
      fy_end = ExpendituresFyDate.find(year).max_paydate.strftime('%Y-%^b-%d')
    rescue ActiveRecord::RecordNotFound => e
      raise e
    end
    write_range_end(fy_end)
  end

  def write_cal_start(year)
    cal_start = Time.parse("#{year}-01-01").in_time_zone.strftime('%Y-%m-%d')
    write_range_start(cal_start)
  end

  def write_cal_end(year)
    cal_end = Time.parse("#{year}-12-31").in_time_zone.strftime('%Y-%m-%d')
    write_range_end(cal_end)
  end

  def write_pd_start(date)
    pd_start = Time.parse(date).in_time_zone.strftime('%Y-%^b-%d')
    write_range_start(pd_start)
  end

  def write_pd_end(date)
    pd_end = Time.parse(date).in_time_zone.strftime('%Y-%^b-%d')
    write_range_end(pd_end)
  end

  def write_range_start(date)
    self[:date_range_start] = date
  end

  def write_range_end(date)
    self[:date_range_end] = date
  end

  def write_dates
    self[:date_request] = Time.now.getlocal.strftime('%Y-%m-%d %H:%M:%S')
    self[:date_ran] = nil
  end
end
