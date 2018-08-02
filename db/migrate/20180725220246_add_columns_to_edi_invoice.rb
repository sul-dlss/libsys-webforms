class AddColumnsToEdiInvoice < ActiveRecord::Migration
  def change
    add_column :edi_invoice, :edi_msg_id, :string
    add_column :edi_invoice, :edi_msg_typ, :string
    add_column :edi_invoice, :edi_msg_seg, :string
    add_column :edi_invoice, :uni_vend_key, :integer
    add_column :edi_invoice, :uni_accrue_or_pay_tax, :string
    add_column :edi_invoice, :edi_stanfd_account, :string
    add_column :edi_invoice, :uni_inv_lib, :string
    add_column :edi_invoice, :uni_inv_key, :integer
    add_column :edi_invoice, :uni_inv_num, :string
    add_column :edi_invoice, :edi_invc_total, :integer
    add_column :edi_invoice, :uni_invc_total, :integer
    add_column :edi_invoice, :edi_total_postage, :integer
    add_column :edi_invoice, :edi_total_freight, :integer
    add_column :edi_invoice, :edi_total_handling, :integer
    add_column :edi_invoice, :edi_total_insurance, :integer
    add_column :edi_invoice, :edi_cur_code, :string
    add_column :edi_invoice, :edi_total_tax, :integer
    add_column :edi_invoice, :edi_exchg_rate, :integer
    add_column :edi_invoice, :edi_tax_rate, :integer
  end
end
