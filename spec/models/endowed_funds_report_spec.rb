require 'rails_helper'

RSpec.describe EndowedFundsReport, type: :model do
  describe 'querying from expenditures' do
    let(:ckeys) { class_double('EndowedFundsReport') }
    it 'should retrieve a set of catalog keys' do
      allow(ckeys).to receive(:ol_cat_key_fund)
        .with(['1000501-1-AACIZ', '1000502-1-AACIX'], '2015-07-01', '2016-06-30')
        .and_return(%w[123 456 789])

      subject = ckeys.ol_cat_key_fund(['1000501-1-AACIZ', '1000502-1-AACIX'], '2015-07-01', '2016-06-30')
      expect(subject).to be_kind_of(Array)
      expect(subject.size).to be 3
    end
    it 'should handle the All SUL Funds selection' do
      allow(ckeys).to receive(:ol_cat_key_fund)
        .with('All SUL Funds', '2015-07-01', '2016-06-30')
        .and_return(%w[456 789 101 112 131 415])

      subject = ckeys.ol_cat_key_fund('All SUL Funds', '2015-07-01', '2016-06-30')
      expect(subject).to be_kind_of(Array)
      expect(subject.size).to be 6
    end
    it 'should retrieve a set of catalog keys' do
      allow(ckeys).to receive(:ol_cat_key_fund)
        .with('1065032-101-NAANF-', '2012-09-01', '2013-08-31')
        .and_return(%w[101 112 131 415])

      subject = ckeys.ol_cat_key_fund('1065032-101-NAANF-', '2012-09-01', '2013-08-31')
      expect(subject).to be_kind_of(Array)
      expect(subject.size).to be 4
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
