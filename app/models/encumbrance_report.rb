###
# Class to model the Encumberances Report table
###
class EncumbranceReport < ActiveRecord::Base
  attr_accessor :fund_select, :show_dates, :fund_id
  self.table_name = 'encumbrance_rpts'

  def self.fundcyc_cycle
    cyc = ('2000'..Time.now.strftime('%Y')).to_a.reverse
    cyc.push('9899', '9798', '9697')
  end
end
