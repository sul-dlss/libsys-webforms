class ExpendituresPaydates < ActiveRecord::Migration[5.0]
  def change
    create_table :expenditures_paydates do |t|
      t.datetime  :pay_date

      t.timestamps null: false
    end
  end
end
