# app/models/expenditures_fy_date.rb
class ExpendituresFyDate < ApplicationRecord
  self.table_name = 'expenditures_fy_dates'
  self.primary_key = 'fy'
end
