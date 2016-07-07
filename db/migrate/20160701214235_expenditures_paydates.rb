class ExpendituresPaydates < ActiveRecord::Migration
  def change
    create_table :expenditures_paydates do |t|
      t.datetime  :pay_date

      t.timestamps null: false
    end
  end
end
