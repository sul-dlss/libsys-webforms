class AddExtraFieldsToCirculationStatisticsReportLog < ActiveRecord::Migration[5.2]
  def change
    add_column :circ_stats_rpt_log, :extra_field3, :string
    add_column :circ_stats_rpt_log, :extra_field4, :string
  end
end
