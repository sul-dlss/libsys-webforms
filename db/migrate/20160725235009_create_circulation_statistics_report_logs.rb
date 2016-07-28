class CreateCirculationStatisticsReportLogs < ActiveRecord::Migration
  def change
    create_table :circ_stats_rpt_log do |t|
      t.datetime :date_request
      t.datetime :date_ran
      t.string :status
      t.string :email
      t.string :call_range
      t.string :libs_locs
      t.string :format
      t.integer :include_inhouse
      t.integer :exclude_inactive
      t.string :blank_columns
      t.string :input_path
      t.string :output_name
      t.string :message
      t.string :extra_field
      t.string :extra_field2
      t.string :ckey_url
      t.string :extras_url
      t.string :link_type
      t.integer :selcall_src
      t.string :summary_only
      t.integer :min_pub_year
      t.integer :max_pub_year
      t.string :exclude_bad_year

      t.timestamps null: false
    end
  end
end
