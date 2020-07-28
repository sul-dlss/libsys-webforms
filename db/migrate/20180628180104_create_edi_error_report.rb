class CreateEdiErrorReport < ActiveRecord::Migration[5.0]
  def change
    create_table :edi_error_report do |t|
      t.datetime :run
      t.string :type
      t.string :error
      t.string :err_lvl

      t.timestamps null: false
    end
  end
end
