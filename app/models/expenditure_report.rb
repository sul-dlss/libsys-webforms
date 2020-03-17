###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpenditureReport < ApplicationRecord
  include FundYearUtils
  attr_accessor :fund, :fund_begin, :fund_select, :date_type, :fy_start, :fy_end,
                :cal_start, :cal_end, :pd_start, :pd_end, :output_file

  validate :email_format
  validate :fund_selection_present
  validate :start_date_present

  before_save :set_fund, :set_output_file, :check_dates

  self.table_name = 'expenditures_log'

  def kickoff
    ActiveRecord::Base.connection.execute("begin expend_rpt.run_rpt('#{output_file}'); end;")
  rescue ActiveRecord::StatementInvalid
  end

  private

  def set_output_file
    self[:output_file] = output_file
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
