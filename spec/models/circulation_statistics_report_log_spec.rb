require 'rails_helper'

RSpec.describe CirculationStatisticsReportLog, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:circulation_statistics_report_log)).to be_valid
  end
end
