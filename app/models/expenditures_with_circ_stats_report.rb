###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpendituresWithCircStatsReport < ApplicationRecord
  include FundYearUtils
  attr_accessor :fund, :fund_begin, :fund_select, :date_type,
                :fy_start, :fy_end, :cal_start, :cal_end, :pd_start, :pd_end,
                :lib_array, :libraries, :format_array, :formats

  validates :date_type, inclusion: %w[fiscal calendar paydate]
  validates :start_date_present?, inclusion: { in: [true], message: 'Please choose a start date for the report.' }
  validate :email_format
  validate :fund_selection_present

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

  def start_date_present?
    case date_type
    when 'calendar'
      cal_start.present?
    when 'fiscal'
      fy_start.present?
    when 'paydate'
      pd_start.present?
    end
  end

  def email_format
    message = 'Email address is missing or not in a correct format'
    errors.add(:base, message) unless email.match(Rails.configuration.email_pattern)
  end

  def fund_selection_present
    message = 'Select either a single Fund ID/PTA or a fund that begins with an ID/PTA number'
    errors.add(:base, message) unless fund.present? || fund_begin.present?
  end
end
