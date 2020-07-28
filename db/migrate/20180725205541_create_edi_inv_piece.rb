class CreateEdiInvPiece < ActiveRecord::Migration[5.0]
  def change
    create_table :edi_inv_piece do |t|
      t.string :edi_vend_id
      t.string :edi_doc_num

      t.timestamps null: false
    end
  end
end
