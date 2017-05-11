require 'rails_helper'

RSpec.describe ExpendituresWithCircStatsReport, type: :model do
  before do
    FactoryGirl.create(:expenditures_fy_date)
  end

  it 'has a valid factory' do
    expect(FactoryGirl.create(:expenditures_with_circ_stats_report)).to be_valid
  end

  describe 'callbacks' do
    before(:all) do
      @report = FactoryGirl.create(:expenditures_with_circ_stats_report)
    end
    it 'has attributes' do
      expect(@report).to have_attributes(status: 'REQUEST')
    end
    it 'checks and writes the funds' do
      expect(@report.send(:set_fund)).to eq(@report.fund.join(','))
      @report.save
      expect(@report.date_range_start).not_to be_nil
    end
    it 'checks and writes the dates' do
      expect(@report.send(:write_fy_start, '2011')).to eq('0010-SEP-03')
      expect(@report.send(:write_fy_end, '2011')).to eq('0011-AUG-25')
      expect(@report.send(:check_fy)).to eq('0011-AUG-25')

      expect(@report.send(:write_cal_start, '2011')).to eq('2011-01-01')
      expect(@report.send(:write_cal_end, '2011')).to eq('2011-12-31')
      expect(@report.send(:write_pd_start, '04-OCT-96')).to eq('0096-10-04')
      expect(@report.send(:write_pd_end, '04-OCT-97')).to eq('0097-10-04')
    end
    it 'sets the attribute for fund_acct with a fund_begin value' do
      @report.update_attribute(:fund, nil)
      expect(@report.send(:set_fund)).to eq('1065032-103-')
    end
    it 'rescues from an error if the fy date is not in the table' do
      expect do
        FactoryGirl.create(:expenditures_with_circ_stats_report, fy_start: 'FY 2015')
      end.to raise_error(ActiveRecord::RecordNotFound)
      expect do
        FactoryGirl.create(:expenditures_with_circ_stats_report, fy_end: 'FY 2015')
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
