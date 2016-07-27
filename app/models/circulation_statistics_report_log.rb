# app/models/circulation_statistics_report_log.rb
class CirculationStatisticsReportLog < ActiveRecord::Base
  self.table_name = 'circ_stats_rpt_log'
  attr_accessor :barcodes
  validates :email, presence: true
  before_validation :strip_whitespace, only: [:email]

  private

  def strip_whitespace
    self.email = email.gsub(/\s+/, '') unless email.nil?
  end
end
