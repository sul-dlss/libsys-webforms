###
# Class to model the Encumberances Report table
###
class EncumbranceReport < ActiveRecord::Base
  attr_accessor :fund_select, :show_dates, :fund, :fund_begin, :email

  validates :email, presence: true
  validates :fund, presence: true, if: 'fund_begin.nil?'
  validates :fund_begin, presence: true, if: 'fund.nil?'

  before_save :set_fund, :write_dates, :set_email

  self.table_name = 'encumbrance_rpts'

  def self.fundcyc_cycle
    cyc = ('2000'..Time.zone.now.strftime('%Y')).to_a.reverse
    cyc.push('9899', '9798', '9697')
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
    self[:date_ran] = Time.zone.now
  end

  def set_email
    self[:email] = email
  end
end
