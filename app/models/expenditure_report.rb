###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpenditureReport < ApplicationRecord
  include FundYearUtils
  attr_accessor :fund, :fund_begin, :fund_select, :date_type, :fy_start, :fy_end,
                :cal_start, :cal_end, :pd_start, :pd_end, :output_file

  validates :email, presence: true
  validates :fund, presence: true, if: :blank_fund_begin?
  validates :fund_begin, presence: true, if: :blank_fund?
  validates :date_type, inclusion: %w[fiscal calendar paydate]
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true

  before_save :set_fund, :set_output_file, :check_dates

  self.table_name = 'expenditures_log'

  def kickoff
    ActiveRecord::Base.connection.execute("begin expend_rpt.run_rpt('#{output_file}'); end;")
  rescue ActiveRecord::StatementInvalid
  end

  private

  def blank_fund_begin?
    fund_begin.blank?
  end

  def blank_fund?
    fund.blank?
  end

  def set_output_file
    self[:output_file] = output_file
  end
end
