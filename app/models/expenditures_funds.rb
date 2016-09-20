###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpendituresFunds < ActiveRecord::Base
  self.table_name = 'expenditures_funds'

  def self.fund_id
    order(fund_id: :asc, fund_name_key: :asc, old_fund_id: :asc, min_pay_date: :asc, max_pay_date: :desc)
  end

  def self.fund_begins_with
    select(:fund_id).where(fund_name_key: [nil, ''])
  end
end
