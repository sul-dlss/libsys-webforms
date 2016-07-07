###
# Class to model EXPENDITURES_FUNDS oracle table
###
class ExpendituresPaydates < ActiveRecord::Base
  attr_accessor :date_range
  self.table_name = 'expenditures_paydates'

  def self.calendar_years
    ('1996'..Time.zone.now.strftime('%Y')).to_a
  end

  def self.fiscal_years
    cyc = ('2000'..Time.zone.now.strftime('%Y')).to_a
    cyc.push('9899', '9798', '9697')
  end

  def self.pay_dates
    order(pay_date: :desc)
  end
end
