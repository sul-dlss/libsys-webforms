###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpenditureReport < ApplicationRecord
  include FundYearUtils
  attr_accessor :fund, :fund_begin, :fund_select, :date_request, :date_ran, :date_type,
                :fy_start, :fy_end, :cal_start, :cal_end, :pd_start, :pd_end, :output_file

  validates :email, presence: true
  validates :fund, presence: true, if: 'fund_begin.nil?'
  validates :fund_begin, presence: true, if: 'fund.nil?'
  validates :date_type, inclusion: %w[fiscal calendar paydate]
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true

  before_save :set_fund, :write_dates, :set_output_file
  before_save :check_fy, if: 'date_type == "fiscal"'
  before_save :check_cal, if: 'date_type == "calendar"'
  before_save :check_pd, if: 'date_type == "paydate"'
  self.table_name = 'expenditures_log'

  def kickoff
    ActiveRecord::Base.connection.execute("begin expend_rpt.run_rpt('#{output_file}'); end;")
  rescue ActiveRecord::StatementInvalid
  end

  private

  def set_output_file
    self[:output_file] = output_file
  end
end
