class EncumbranceReport < ActiveRecord::Migration[5.0]
  def change
    create_table :encumbrance_rpts do |t|
      t.datetime  :date_request
      t.datetime  :date_ran
      t.string    :status
      t.string    :email
      t.string    :fund_acct, array: true
      t.string    :fundcyc_cycle
      t.string    :funding_paid
      t.string    :output_file
      t.string    :message

      t.timestamps null: false
    end
  end
end
