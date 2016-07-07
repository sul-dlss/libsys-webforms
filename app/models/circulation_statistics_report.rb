# app/models/circulation_statistics_report.rb
class CirculationStatisticsReport
  include ActiveModel::Model
  attr_accessor :email, :libraries, :source, :range_type, :low_callnum_range, :hi_callnum_range
end
