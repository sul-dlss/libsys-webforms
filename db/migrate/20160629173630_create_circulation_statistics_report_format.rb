class CreateCirculationStatisticsReportFormat < ActiveRecord::Migration
  def change
    create_table :circ_stats_rpt_fmts do |t|
      t.string :format
    end
  end
end
