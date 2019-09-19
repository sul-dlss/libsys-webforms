###
# Class to model the Encumberances Report table
###
class EncumbranceReport < ApplicationRecord
  attr_accessor :fund_select, :show_dates, :fund, :fund_begin, :email, :status,
                :date_ran, :date_request, :output_file, :fund_acct

  validates :email, presence: true
  validates :fund, presence: true, if: :blank_fund_begin?
  validates :fund_begin, presence: true, if: :blank_fund?
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true

  before_save :set_fund, :write_dates, :set_email, :set_status, :set_output_file

  self.table_name = 'encumbrance_rpts'

  def kickoff
    ActiveRecord::Base.connection.execute("begin encumb_rpt.run_rpt('#{output_file}'); end;")
  rescue ActiveRecord::StatementInvalid
  end

  private

  def blank_fund_begin?
    fund_begin.blank?
  end

  def blank_fund?
    fund.blank?
  end

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
end
