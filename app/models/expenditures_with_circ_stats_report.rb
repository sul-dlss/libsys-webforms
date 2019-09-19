###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpendituresWithCircStatsReport < ApplicationRecord
  include FundYearUtils
  attr_accessor :fund, :fund_begin, :fund_select, :date_type,
                :fy_start, :fy_end, :cal_start, :cal_end, :pd_start, :pd_end,
                :lib_array, :libraries, :format_array, :formats

  validates :fund, presence: true, if: :blank_fund_begin?
  validates :fund_begin, presence: true, if: :blank_fund?
  validates :lib_array, presence: true
  validates :format_array, presence: true
  validates :date_type, inclusion: %w[fiscal calendar paydate]

  before_save :set_fund, :write_lib, :write_fmt, :check_dates

  self.table_name = 'expenditures_circ_log'

  private

  def blank_fund_begin?
    fund_begin.blank?
  end

  def blank_fund?
    fund.blank?
  end

  def write_lib
    self[:libraries] = lib_array.delete_if { |a| a.empty? || a == 'All Libraries' }.join(',')
  end

  def write_fmt
    self[:formats] = format_array.delete_if { |a| a.empty? || a == 'All Formats' }.join(',')
  end
end
