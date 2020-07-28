class CreateEdiLin < ActiveRecord::Migration[5.0]
  def change
    create_table :edi_lin do |t|
      t.string :doc_num
      t.string :vend_id
      t.integer :edi_lin_num
      t.integer :edi_sublin_count
      t.string :vend_unique_id

      t.timestamps null: false
    end
  end
end
