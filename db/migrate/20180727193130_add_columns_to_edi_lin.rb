class AddColumnsToEdiLin < ActiveRecord::Migration
  def change
    add_column :edi_lin, :barcode_num, :integer, limit: 6
  end
end
