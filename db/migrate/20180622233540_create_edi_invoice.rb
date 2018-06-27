class CreateEdiInvoice < ActiveRecord::Migration
  def change
    create_table :edi_invoice do |t|
      t.string :edi_doc_num
      t.string :edi_vend_id
      t.datetime :edi_vend_inv_date
      t.string :todo
      t.datetime :uni_inv_cre_date
      t.integer :edi_total_pieces
      t.timestamps null: false
    end
  end
end
