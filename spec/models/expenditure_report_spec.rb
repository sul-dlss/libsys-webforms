require 'rails_helper'

RSpec.describe ExpenditureReport, type: :model do
  before(:all) do
    FactoryBot.create(:expenditures_fy_date)
    FactoryBot.create(:expenditures_fy_date,
                      fy: 2011,
                      min_paydate: '0010-09-03 00:00:00',
                      max_paydate: '0011-08-25 00:00:00')
  end
  it 'has a valid factory' do
    expect(FactoryBot.create(:expenditure_report)).to be_valid
  end

  describe 'callbacks' do
    before do
      @report = FactoryBot.create(:expenditure_report)
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
      expect(@report.send(:write_fy_start, '2009')).to eq('0008-SEP-05')
      expect(@report.send(:write_fy_end, '2011')).to eq('0011-AUG-25')
      expect(@report.send(:check_fy)).to eq('0011-AUG-25')

      expect(@report.send(:write_cal_start, '2011')).to eq('2011-01-01')
      expect(@report.send(:write_cal_end, '2011')).to eq('2011-12-31')
      expect(@report.send(:write_pd_start, '04-OCT-96')).to eq('1996-OCT-04')
      expect(@report.send(:write_pd_end, '04-OCT-97')).to eq('1997-OCT-04')
    end
    it 'sets the attribute for fund_acct with a fund_begin value' do
      @report.update_attributes(fund: nil)
      expect(@report.send(:set_fund)).to eq('1065032-103-')
    end
  end
end
