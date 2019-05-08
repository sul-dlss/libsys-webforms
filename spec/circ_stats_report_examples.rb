require 'rails_helper'

RSpec.shared_examples 'circ_stats_report_examples' do
  describe '#lc_call_lo' do
    it 'validates whether lc low callnum range is at most two uppercase letters or one plus #' do
      message = 'Low callnum range must be at most two uppercase letters or one plus #'
      report = CirculationStatisticsReport.new(valid_attributes.merge!(range_type: 'lc', call_lo: 'LLL'))
      report.valid?
      expect(report.errors.full_messages).to include(message)
    end
  end

  describe '#lc_call_hi' do
    it 'validates whether lc hi callnum range is empty or a later letter than low range' do
      message = 'Hi callnum range must be empty or a later letter.'
      report = CirculationStatisticsReport.new(valid_attributes.merge!(range_type: 'lc', call_lo: 'L', call_hi: 'A'))
      report.valid?
      expect(report.errors.full_messages).to include(message)
    end
    it 'validates whether lc hi callnum range is empty or has two letters with the same first letter as low range' do
      message = 'Hi callnum range must be empty or two letters with the same first letter as low range'
      report = CirculationStatisticsReport.new(valid_attributes.merge!(range_type: 'lc', call_lo: 'LL', call_hi: 'AA'))
      report.valid?
      expect(report.errors.full_messages).to include(message)
    end
    it 'validates whether lc hi callnum range is empty when lo range is a letter followed by #' do
      message = 'Hi callnum range must be empty.'
      report = CirculationStatisticsReport.new(valid_attributes.merge!(range_type: 'lc', call_lo: 'L#', call_hi: 'AA'))
      report.valid?
      expect(report.errors.full_messages).to include(message)
    end
  end

  describe '#classic_call_lo_and_hi' do
    it 'validates whether classic call_lo and call_hi are all digits, with lo lower than hi' do
      message = 'Low and hi callnum range must be all digits, with lo lower than hi.'
      report = CirculationStatisticsReport.new(valid_attributes.merge!(range_type: 'classic',
                                                                       call_lo: '2',
                                                                       call_hi: '1'))
      report.valid?
      expect(report.errors.full_messages).to include(message)
    end
  end

  describe '#classic_call_alpha' do
    it 'validates whether classic call_alpha is associated with correct low and hi callnum ranges' do
      message = 'Low and hi callnum ranges must be one to four digits.'
      report = CirculationStatisticsReport.new(valid_attributes.merge!(range_type: 'classic',
                                                                       call_alpha: '12',
                                                                       call_lo: 'A',
                                                                       call_hi: 'B'))
      report.valid?
      expect(report.errors.full_messages).to include(message)
    end
  end
end
