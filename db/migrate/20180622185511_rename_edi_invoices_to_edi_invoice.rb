class RenameEdiInvoicesToEdiInvoice < ActiveRecord::Migration
  def change
    rename_table :edi_invoices, :edi_invoice
  end
end
