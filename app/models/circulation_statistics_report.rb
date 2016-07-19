# app/models/circulation_statistics_report.rb
class CirculationStatisticsReport
  include ActiveModel::Model
  attr_accessor :email, :lib_array, :source, :range_type, :call_lo, :call_hi,
                :call_alpha, :barcodes
  validates :email, :lib_array, :call_lo, presence: true
end
