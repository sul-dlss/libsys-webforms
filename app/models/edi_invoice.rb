# Model for EDI Invoice
class EdiInvoice < ActiveRecord::Base
  scope :vendfilter, lambda { |vend|
    vend == 'ALL' ? vend = edi_vend_id : vend
    where(edi_vend_id: vend)
  }

  self.table_name = 'edi_invoice'
  self.primary_keys = :edi_vend_id, :edi_doc_num

  def self.make_updates(vendor, invoice)
    @edi_invoice = where('edi_vend_id = ? AND edi_doc_num = ?', vendor, invoice)
    if @edi_invoice.present?
      if %w(CreInvc SKIP CreOrd Excld).include?(@edi_invoice.pluck(:todo)[0].to_s)
        ['error', "Invoice NOT excluded! #{@edi_invoice.edi_vend_id[0]} invoice no. #{@edi_invoice.edi_doc_num} "\
                  'is already through EDI processing past the point of safe Exclusion via web form.']
      else
        update_edi_invoice
        delete_edi_inv_line
        delete_edi_piece
        ['warning', "#{@edi_invoice.edi_vend_id[0]} invoice no. #{@edi_invoice.edi_doc_num} "\
                    'excluded from EDI processing']
      end
    else
      insert_edi_invoice(vendor, invoice)
      ['warning', "#{@edi_invoice.edi_vend_id[0]} invoice no. #{@edi_invoice.edi_doc_num}, "\
                  'excluded from EDI processing']
    end
  end

  def self.update_edi_invoice
    edi_invoice = @edi_invoice.first
    edi_invoice.todo = 'Excld'
    edi_invoice.uni_vend_key = nil
    edi_invoice.uni_accrue_or_pay_tax = nil
    edi_invoice.edi_stanfd_account = nil
    edi_invoice.uni_inv_lib = nil
    edi_invoice.uni_inv_key = nil
    edi_invoice.uni_inv_num.to_s << '<-Excld'
    edi_invoice.edi_invc_total = 0
    edi_invoice.uni_invc_total = 0
    edi_invoice.edi_total_postage = 0
    edi_invoice.edi_total_freight = 0
    edi_invoice.edi_total_handling = 0
    edi_invoice.edi_total_insurance = 0
    edi_invoice.edi_cur_code = nil
    edi_invoice.edi_total_tax = 0
    edi_invoice.edi_exchg_rate = nil
    edi_invoice.edi_tax_rate = nil
    edi_invoice.edi_total_pieces = 0
    edi_invoice.save
  end

  def self.delete_edi_inv_line
    EdiInvLine.delete_all(['edi_doc_num = ? AND edi_vend_id = ?',
                           @edi_invoice.edi_doc_num,
                           @edi_invoice.edi_vend_id[0]])
  end

  def self.delete_edi_piece
    EdiInvPiece.delete_all(['edi_doc_num = ? AND edi_vend_id = ?',
                            @edi_invoice.edi_doc_num,
                            @edi_invoice.edi_vend_id[0]])
  end

  def self.insert_edi_invoice(vendor, invoice)
    excld = EdiInvoice.new
    excld.edi_doc_num = invoice
    excld.edi_vend_id = vendor
    excld.edi_msg_id = 'Excld'
    excld.edi_msg_typ = 'INVOIC'
    excld.todo = 'Excld'
    excld.edi_msg_seg = 'HDR'
    excld.save
  end

  def self.edi_doc_num
    pluck(:edi_doc_num)[0]
  end

  def self.edi_vend_id
    distinct.pluck(:edi_vend_id)
  end

  def self.vendor_filter
    %w[ALL].push(*edi_vend_id)
  end
end
