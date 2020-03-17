###
# Class to model the Encumberances Report table
###
class EncumbranceReport < ApplicationRecord
  attr_accessor :fund_select, :show_dates, :fund, :fund_begin, :email, :status,
                :date_ran, :date_request, :output_file, :fund_acct

  validate :email_format
  validate :fund_selection_present

  before_save :set_fund, :write_dates, :set_email, :set_status, :set_output_file

  self.table_name = 'encumbrance_rpts'

  def kickoff
    ActiveRecord::Base.connection.execute("begin encumb_rpt.run_rpt('#{output_file}'); end;")
  rescue ActiveRecord::StatementInvalid
  end

  private

  def set_fund
    if fund.present?
      self[:fund_acct] = fund.join(',')
    elsif fund_begin.present?
      self[:fund_acct] = fund_begin
    end
  end

  def write_dates
    self[:date_request] = date_request
  end

  def set_email
    self[:email] = email
  end

  def set_status
    self[:status] = status
  end

  def set_output_file
    self[:output_file] = output_file
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
