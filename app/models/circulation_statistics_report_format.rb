# app/models/circulation_statistics_report_format.rb
class CirculationStatisticsReportFormat < ApplicationRecord
  self.table_name = 'circ_stats_rpt_fmts'

  def self.formats
    select(:format).distinct.order(:format).pluck(:format).sort.unshift('All Formats')
  end
end
