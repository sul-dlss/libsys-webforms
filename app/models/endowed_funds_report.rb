###
# Class to model EXPENDITURES oracle table
###
class EndowedFundsReport
  include ActiveModel::Model
  attr_accessor :fund, :fund_begin, :fund_select, :report_format,
                :date_request, :date_ran, :date_type,
                :fy_start, :fy_end, :cal_start, :cal_end, :pd_start, :pd_end,
                :email

  validates :fund, presence: true, if: 'fund_begin.nil?'
  validates :fund_begin, presence: true, if: 'fund.nil?'

  # before_save :set_fund, :check_fy, :check_cal, :check_pd, :write_dates
  # self.table_name = 'expenditures'

  # def self.foo
  #   where...
  # end

  def self.ol_cat_key
    where('ta_fund_code in (?)', :ta_fund_code)
  end

  private

  def set_fund
    if fund
      self[:ta_fund_code] = fund
    elsif fund_begin
      self[:ta_fund_code] = fund_begin
    end
  end

  def check_fy
    return unless fy_start.present? && fy_end.present?
    write_fy_start(fy_start.sub('FY', ''))
    write_fy_end(fy_end.sub('FY', ''))
  end

  def check_cal
    return unless cal_start.present? && cal_end.present?
    write_cal_start(cal_start)
    write_cal_end(cal_end)
  end

  def check_pd
    return unless pd_start.present? && pd_end.present?
    write_pd_start(pd_start)
    write_pd_end(pd_end)
  end

  def write_fy_start(year)
    fy_start = Time.zone.parse("#{year}-07-01").strftime('%Y-%m-%d')
    write_range_start(fy_start)
  end

  def write_fy_end(year)
    fy_end = Time.zone.parse("#{year}-06-30").strftime('%Y-%m-%d')
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
    pd_start = Time.zone.parse(date).strftime('%Y-%m-%d')
    write_range_start(pd_start)
  end

  def write_pd_end(date)
    pd_end = Time.zone.parse(date).strftime('%Y-%m-%d')
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
    self[:date_ran] = Time.zone.now
  end
end
