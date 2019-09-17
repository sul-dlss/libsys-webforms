###
# Class to model the Encumberances Report table
###
class EncumbranceReport < ApplicationRecord
  attr_accessor :fund_select, :show_dates, :fund, :fund_begin, :email,
                :date_ran, :date_request, :output_file

  validates :email, presence: true
  validates :fund, presence: true, if: -> { :fund_begin.blank? }
  validates :fund_begin, presence: true, if: -> { :fund.blank? }
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true

  before_save :set_fund, :write_dates, :set_email, :set_output_file

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
    self[:date_request] = Time.zone.now
    self[:date_ran] = nil
  end

  def set_email
    self[:email] = email
  end

  def set_output_file
    self[:output_file] = output_file
  end
end
