require 'rails_helper'

RSpec.describe ExpendituresWithCircStatsReport, type: :model do
  before do
    FactoryBot.create(:expenditures_fy_date)
  end

  it 'has a valid factory' do
    expect(FactoryBot.create(:expenditures_with_circ_stats_report)).to be_valid
  end

  describe 'callbacks' do
    before do
      @report = FactoryBot.create(:expenditures_with_circ_stats_report)
    end

    it 'has attributes' do
      expect(@report).to have_attributes(status: 'REQUEST')
    end
    it 'checks the funds' do
      expect(@report.send(:set_fund)).to eq(@report.fund.join(','))
    end
    it 'writes the funds' do
      @report.save
      expect(@report.date_range_start).not_to be_nil
    end

    describe 'checking the report dates' do
      it 'writes fy_start' do
        expect(@report.send(:write_fy_start, '2011')).to eq('2010-SEP-03')
      end
      it 'writes fy_end' do
        expect(@report.send(:write_fy_end, '2011')).to eq('2011-AUG-25')
      end
      it 'checks fiscal year dates' do
        expect(@report.send(:check_fy)).to eq('2011-AUG-25')
      end
      it 'writes cal_start' do
        expect(@report.send(:write_cal_start, '2011')).to eq('2011-01-01')
      end
      it 'writes cal_end' do
        expect(@report.send(:write_cal_end, '2011')).to eq('2011-12-31')
      end
      it 'writes pd_start' do
        expect(@report.send(:write_pd_start, '04-OCT-96')).to eq('1996-OCT-04')
      end
      it 'writes pd_end' do
        expect(@report.send(:write_pd_end, '04-OCT-97')).to eq('1997-OCT-04')
      end
    end

    it 'sets the attribute for fund_acct with a fund_begin value' do
      @report.update(fund: nil)
      expect(@report.send(:set_fund)).to eq('1065032-103-')
    end
    it 'rescues from an error if the fy start date is not in the table' do
      expect do
        FactoryBot.create(:expenditures_with_circ_stats_report, fy_start: 'FY 2018')
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
    it 'rescues from an error if the fy end date is not in the table' do
      expect do
        FactoryBot.create(:expenditures_with_circ_stats_report, fy_end: 'FY 2018')
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
