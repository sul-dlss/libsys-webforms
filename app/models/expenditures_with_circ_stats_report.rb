###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpendituresWithCircStatsReport < ApplicationRecord
  include FundYearUtils
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

  def write_lib
    self[:libraries] = lib_array.delete_if { |a| a == '' || a == 'All Libraries' }.join(',')
  end

  def write_fmt
    self[:formats] = format_array.delete_if { |a| a == '' || a == 'All Formats' }.join(',')
  end

  def write_dates
    self[:date_request] = Time.zone.now
  end
end
