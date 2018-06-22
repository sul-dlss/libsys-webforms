class CreateEdiInvoices < ActiveRecord::Migration
  def change
    create_table :edi_invoices do |t|

      t.timestamps null: false
    end
  end
end
