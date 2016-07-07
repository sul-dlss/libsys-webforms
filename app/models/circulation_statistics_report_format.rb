# app/models/circulation_statistics_report_format.rb
class CirculationStatisticsReportFormat < ActiveRecord::Base
  self.table_name = 'circ_stats_rpt_fmts'

  def self.formats
    select(:format).distinct.order(:format).pluck(:format)
  end
end
