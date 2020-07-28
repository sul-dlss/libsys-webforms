class CreateExpendituresFyDates < ActiveRecord::Migration[5.0]
  def change
    create_table :expenditures_fy_dates do |t|
      t.integer :fy
      t.datetime :min_paydate
      t.datetime :max_paydate

      t.timestamps null: false
    end
  end
end
