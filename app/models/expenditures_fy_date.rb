# app/models/expenditures_fy_date.rb
class ExpendituresFyDate < ActiveRecord::Base
  self.table_name = 'expenditures_fy_dates'
  self.primary_key = 'fy'
end
