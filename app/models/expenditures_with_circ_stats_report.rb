###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpendituresWithCircStatsReport < ApplicationRecord
  include FundUtils
  attr_accessor :fund, :fund_begin, :fund_select, :date_type,
                :fy_start, :fy_end, :cal_start, :cal_end, :pd_start, :pd_end,
                :lib_array, :libraries, :format_array, :formats

  validate :email_format
  validate :fund_selection_present
  validate :start_date_present

  before_save :set_fund, :write_lib, :write_fmt, :check_dates, :set_output_file

  self.table_name = 'expenditures_circ_log'

  def kickoff
    ActiveRecord::Base.connection.execute("begin expend_rpt.run_rpt_circ('#{output_file}'); end;")
  rescue ActiveRecord::StatementInvalid
  end

  private

  def set_output_file
    self[:output_file] = output_file
  end

  def write_lib
    self[:libraries] = lib_array.delete_if { |a| a.empty? || a == 'All Libraries' }.join(',')
  end

  def write_fmt
    self[:formats] = format_array.delete_if { |a| a.empty? || a == 'All Formats' }.join(',')
  end

  def start_date_present
    message = 'Choose a start date for fiscal, calendar, or paid date'
    errors.add(:base, message) unless type_of_date_present?
  end

  def type_of_date_present?
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
    message = 'Select a single Fund ID/PTA, a fund that begins with an ID/PTA number, or all SUL funds'
    errors.add(:base, message) unless fund.present? || fund_begin.present?
  end
end
