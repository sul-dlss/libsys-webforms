# Model for EDI Invoice
class EdiInvoice < ApplicationRecord
  scope :vendfilter, lambda { |vend|
    vend == 'ALL' ? vend = edi_vend_id : vend
    where(edi_vend_id: vend)
  }

  self.table_name = 'edi_invoice'
  self.primary_keys = :edi_vend_id, :edi_doc_num

  def self.make_updates(vendor, invoice)
    @edi_invoice = where('edi_vend_id = ? AND edi_doc_num = ?', vendor, invoice)
    if @edi_invoice.present?
      if %w(CreInvc SKIP CreOrd Excld).exclude?(@edi_invoice.pluck(:todo)[0].to_s)
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
    edi_invoice.update(
      todo: 'Excld', uni_vend_key: nil, uni_accrue_or_pay_tax: nil, edi_stanfd_account: nil, uni_inv_lib: nil,
      uni_inv_key: nil, uni_inv_num: "#{edi_invoice.uni_inv_num}<-Excld", edi_invc_total: 0, uni_invc_total: 0,
      edi_total_postage: 0, edi_total_freight: 0, edi_total_handling: 0, edi_total_insurance: 0, edi_cur_code: nil,
      edi_total_tax: 0, edi_exchg_rate: nil, edi_tax_rate: nil, edi_total_pieces: 0
    )
    edi_invoice.save
  end

  def self.delete_edi_inv_line
    EdiInvLine.where('edi_doc_num = ? AND edi_vend_id = ?',
                     @edi_invoice.edi_doc_num,
                     @edi_invoice.edi_vend_id[0]).delete_all
  end

  def self.delete_edi_piece
    EdiInvPiece.where('edi_doc_num = ? AND edi_vend_id = ?',
                      @edi_invoice.edi_doc_num,
                      @edi_invoice.edi_vend_id[0]).delete_all
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
