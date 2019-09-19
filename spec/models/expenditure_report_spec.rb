require 'rails_helper'

RSpec.describe ExpenditureReport, type: :model do
  before do
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

    context 'when setting the start end end date range' do
      before do
        @report.send(:check_dates)
      end

      it 'sets the date_range_start' do
        expect(@report.date_range_start).to eq '2008-09-05 00:00:00.000000000 -0700'
      end
      it 'sets the date_range_end' do
        expect(@report.date_range_end).to eq '2011-08-25 00:00:00.000000000 -0700'
      end
    end

    it 'checks the funds' do
      expect(@report.send(:set_fund)).to eq(@report.fund.join(','))
    end
    it 'writes the funds' do
      @report.save
      expect(@report.date_range_start).not_to be_nil
    end
    it 'checks the report dates' do
      expect(@report.send(:check_fy)).to eq('2011-AUG-25')
    end
    it 'checks and writes the fy_start dates' do
      expect(@report.send(:write_fy_start, '2009')).to eq('2008-SEP-05')
    end
    it 'checks and writes the fy_end dates' do
      expect(@report.send(:write_fy_end, '2011')).to eq('2011-AUG-25')
    end
    it 'checks and writes the cal_start dates' do
      expect(@report.send(:write_cal_start, '2011')).to eq('2011-01-01')
    end
    it 'checks and writes the cal_end dates' do
      expect(@report.send(:write_cal_end, '2011')).to eq('2011-12-31')
    end
    it 'checks and writes the pd_start dates' do
      expect(@report.send(:write_pd_start, '04-OCT-96')).to eq('1996-OCT-04')
    end
    it 'checks and writes the pd_end dates' do
      expect(@report.send(:write_pd_end, '04-OCT-97')).to eq('1997-OCT-04')
    end
    it 'sets the attribute for fund_acct with a fund_begin value' do
      @report.update(fund: nil)
      expect(@report.send(:set_fund)).to eq('1065032-103-')
    end
  end

  describe 'validations' do
    before do
      @report = described_class.new(date_type: nil, email: nil, fund_begin: nil, fund: nil)
      @report.valid?
    end

    it 'validates the inclusion of a date_type' do
      expect(@report.errors.messages[:date_type]).to include 'is not included in the list'
    end
    it 'validates the presence of an email address' do
      expect(@report.errors.messages[:email]).to include "can't be blank"
    end
    it 'validates the presence of a fund_begin' do
      expect(@report.errors.messages[:fund_begin]).to include "can't be blank"
    end
    it 'validates the presence of a fund' do
      expect(@report.errors.messages[:fund]).to include "can't be blank"
    end
    it 'validates the correct form of an email address' do
      @report = described_class.new(email: 'test@testtest.com')
      @report.valid?
      expect(@report.errors.messages[:email]).not_to include "can't be blank"
    end
    it 'validates the incorrect form of an email address' do
      @report = described_class.new(email: 'test@test@test.com')
      @report.valid?
      expect(@report.errors.messages[:email]).to include 'is invalid'
    end
  end
end
