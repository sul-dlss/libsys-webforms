require 'rails_helper'

RSpec.describe ExpenditureReport, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:expenditure_report)).to be_valid
  end

  describe 'callbacks' do
    before do
      @report = FactoryGirl.create(:expenditure_report)
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
      expect(@report.send(:write_fy_start, '2011')).to eq('2011-07-01')
      expect(@report.send(:write_fy_end, '2011')).to eq('2011-06-30')
      expect(@report.send(:check_fy)).to eq('2011-06-30')

      expect(@report.send(:write_cal_start, '2011')).to eq('2011-01-01')
      expect(@report.send(:write_cal_end, '2011')).to eq('2011-12-31')
      expect(@report.send(:write_pd_start, '04-OCT-96')).to eq('0096-10-04')
      expect(@report.send(:write_pd_end, '04-OCT-97')).to eq('0097-10-04')
    end
    it 'sets the attribute for fund_acct with a fund_begin value' do
      @report.update_attribute(:fund, nil)
      expect(@report.send(:set_fund)).to eq('1065032-103-')
    end
  end
end
