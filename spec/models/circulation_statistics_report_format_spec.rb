require 'rails_helper'

RSpec.describe CirculationStatisticsReportFormat do
  describe 'CirculationStatisticsReportFormat' do
    it 'has a valid factory' do
      expect(create(:circulation_statistics_report_format)).to be_valid
    end

    it 'returns a list of formats' do
      create(:circulation_statistics_report_format)
      expect(described_class.formats).to eq(['All Formats', 'EQUIP'])
    end
  end
end
