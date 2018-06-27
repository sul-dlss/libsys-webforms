# Model for EDI Invoice
class EdiInvoice < ActiveRecord::Base
  scope :vendfilter, lambda { |vend|
    vend == 'ALL' ? vend = edi_vend_id : vend
    where(edi_vend_id: vend)
  }

  self.table_name = 'edi_invoice'

  def self.edi_vend_id
    distinct.pluck(:edi_vend_id)
  end

  def self.vendor_filter
    %w[ALL].push(*edi_vend_id)
  end
end
