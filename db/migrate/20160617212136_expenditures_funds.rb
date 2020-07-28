class ExpendituresFunds < ActiveRecord::Migration[5.0]
  def change
    create_table  :expenditures_funds do |t|
      t.string    :fund_id, array: true
      t.string    :fund_name_key
      t.string    :old_fund_id
      t.datetime  :min_pay_date
      t.datetime  :max_pay_date
      t.integer   :is_endow
      t.string    :inv_lib

      t.timestamps null: false
    end
  end
end
