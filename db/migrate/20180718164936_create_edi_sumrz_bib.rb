class CreateEdiSumrzBib < ActiveRecord::Migration
  def change
    create_table :edi_sumrz_bib do |t|
      t.string :vend_code
      t.string :id001
      t.integer :edi_ckey
      t.datetime :load_date
      t.integer :active_record

      t.timestamps null: false
    end
  end
end
