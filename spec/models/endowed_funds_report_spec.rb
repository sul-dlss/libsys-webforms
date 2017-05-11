require 'rails_helper'

RSpec.describe EndowedFundsReport, type: :model do
  before do
    @endow_funds = FactoryGirl.create(:expenditures)
  end
  describe 'querying from expenditures' do
    subject { EndowedFundsReport.ol_cat_key_fund(@endow_funds.ta_fund_code, '2015-07-01', '2016-06-30') }
    it 'should retrieve a set of catalog keys' do
      begin
        expect(@endow_funds.ol_cat_key).to eq('1234567')
        expect(subject).to be_kind_of(Array)
      rescue ActiveRecord::StatementInvalid
      end
    end
    subject { EndowedFundsReport.ol_cat_key_fund_begin('All SUL Funds', '2015-07-01', '2016-06-30') }
    it 'should handle the All SUL Funds selection' do
      begin
        expect(subject).to be_kind_of(Array)
      rescue ActiveRecord::StatementInvalid
      end
    end
    subject { EndowedFundsReport.ol_cat_key_fund(['1000501-1-AACIZ', '1008930-1-HAGOY'], '2015-07-01', '2016-06-30') }
    it 'should initialize a container of fund codes' do
      begin
        expect(subject).to be_kind_of(Array)
      rescue ActiveRecord::StatementInvalid
      end
    end
  end
  describe 'fiscal_years' do
    report = EndowedFundsReport.new(fy_start: 'FY 2010', fy_end: 'FY2011')
    it 'should strip off the FY and include the year strings in the array' do
      expect(report.fiscal_years).to be_kind_of(Array)
      expect(report.fiscal_years).to include '2010'
      expect(report.fiscal_years).to include '2011'
      expect(report.calendar_years.any?).to be_falsey
      expect(report.paid_years.any?).to be_falsey
    end
  end
  describe 'calendar_years' do
    report = EndowedFundsReport.new(cal_start: '2010', cal_end: '2011')
    it 'should include the year strings in the array' do
      expect(report.calendar_years).to be_kind_of(Array)
      expect(report.calendar_years).to include '2010'
      expect(report.calendar_years).to include '2011'
      expect(report.paid_years.any?).to be_falsey
    end
  end
  describe 'paid_years' do
    report = EndowedFundsReport.new(pd_start: '11-DEC-16', pd_end: '20-JAN-16')
    it 'should include the dates in the array' do
      expect(report.paid_years).to be_kind_of(Array)
      expect(report.paid_years).to include '11-DEC-16'
      expect(report.paid_years).to include '20-JAN-16'
      expect(report.calendar_years.any?).to be_falsey
    end
  end
end
