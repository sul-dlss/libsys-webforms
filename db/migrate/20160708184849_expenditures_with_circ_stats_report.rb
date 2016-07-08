class ExpendituresWithCircStatsReport < ActiveRecord::Migration
  def change
    create_table :expenditures_circ_log do |t|
      t.datetime  :date_request
      t.datetime  :date_ran
      t.string    :status
      t.string    :email
      t.string    :ta_fund_code, array: true
      t.datetime  :date_range_start
      t.datetime  :date_range_end
      t.string    :libraries
      t.string    :formats, array: true
      t.integer   :one_row_total
      t.string    :output_file
      t.string    :message
      t.integer   :ckey_link

      t.timestamps null: false
    end
  end
end
