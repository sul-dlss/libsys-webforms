class CreateEdiInvLine < ActiveRecord::Migration
  def change
    create_table :edi_inv_line, primary_key: 'tbl_row_num' do |t|
      t.string :edi_vend_id
      t.string :edi_doc_num
      t.integer :edi_line_num
      t.string :edi_fund
      t.string :edi_po_number
      t.float :edi_line_net
      t.float :edi_line_gross

      t.timestamps null: false
    end
  end
end
