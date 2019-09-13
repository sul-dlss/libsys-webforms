# Model for EDI Invoice Line
class EdiInvLine < ApplicationRecord
  validates :edi_fund, presence: { message: 'There must be a fund name!' }, on: :update
  self.table_name = 'edi_inv_line'
  self.primary_key = 'tbl_row_num'
end
