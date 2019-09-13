require 'rails_helper'

RSpec.describe CirculationStatisticsReportFormat, type: :model do
  describe 'CirculationStatisticsReportFormat' do
    it 'has a valid factory' do
      expect(FactoryBot.create(:circulation_statistics_report_format)).to be_valid
    end

    it 'returns a list of formats' do
      FactoryBot.create(:circulation_statistics_report_format)
      expect(described_class.formats).to eq(['All Formats', 'EQUIP'])
    end
  end
end
