require 'rails_helper'

# rubocop:disable  Metrics/BlockLength
RSpec.describe EndowedFundsReport, type: :model do
  describe 'querying from expenditures' do
    let(:ckeys) { class_double('EndowedFundsReport') }

    it 'retrieves a set of catalog keys' do
      allow(ckeys).to receive(:ol_cat_key_fund)
        .with(%w(1000501-1-AACIZ 1000502-1-AACIX), '2015-07-01', '2016-06-30')
        .and_return(%w[123 456 789])

      subject = ckeys.ol_cat_key_fund(%w(1000501-1-AACIZ 1000502-1-AACIX), '2015-07-01', '2016-06-30')
      expect(subject.size).to be 3
    end

    it 'handles the All SUL Funds selection' do
      allow(ckeys).to receive(:ol_cat_key_fund)
        .with('All SUL Funds', '2015-07-01', '2016-06-30')
        .and_return(%w[456 789 101 112 131 415])

      subject = ckeys.ol_cat_key_fund('All SUL Funds', '2015-07-01', '2016-06-30')
      expect(subject.size).to be 6
    end

    it 'retrieves a set of catalog keys from a partial fund name' do
      allow(ckeys).to receive(:ol_cat_key_fund)
        .with('1065032-101-NAANF-', '2012-09-01', '2013-08-31')
        .and_return(%w[101 112 131 415])

      subject = ckeys.ol_cat_key_fund('1065032-101-NAANF-', '2012-09-01', '2013-08-31')
      expect(subject.size).to be 4
    end
  end

  describe 'fiscal_years' do
    let(:report) { described_class.new(fy_start: 'FY 2010', fy_end: 'FY2011') }

    it 'strips off the FY and include the start year string in the array' do
      expect(report.fiscal_years).to include '2010'
    end

    it 'strips off the FY and include the end year string in the array' do
      expect(report.fiscal_years).to include '2011'
    end

    it 'does not have calender years' do
      expect(report.calendar_years).not_to be_any
    end

    it 'does not have paid years' do
      expect(report.paid_years).not_to be_any
    end
  end

  describe 'calendar_years' do
    let(:report) { described_class.new(cal_start: '2010', cal_end: '2011') }

    it 'includes the start year string in the array' do
      expect(report.calendar_years).to include '2010'
    end

    it 'includes the end year string in the array' do
      expect(report.calendar_years).to include '2011'
    end

    it 'does not have fiscal years' do
      expect(report.fiscal_years).not_to be_any
    end

    it 'does not have paid years' do
      expect(report.paid_years).not_to be_any
    end
  end

  describe 'paid_years' do
    let(:report) { described_class.new(pd_start: '11-DEC-16', pd_end: '20-JAN-16') }

    it 'includes the start date in the array' do
      expect(report.paid_years).to include '11-DEC-16'
    end

    it 'includes the end date in the array' do
      expect(report.paid_years).to include '20-JAN-16'
    end

    it 'does not have fiscal years' do
      expect(report.fiscal_years).not_to be_any
    end

    it 'does not have calender years' do
      expect(report.calendar_years).not_to be_any
    end
  end

  describe 'validations' do
    before do
      @report = described_class.new(email: nil, fund_begin: nil, fund: nil,
                                    fy_start: nil, cal_start: nil, pd_start: nil)
      @report.valid?
    end

    it 'validated the presence of fy start date' do
      expect(@report.errors.messages[:fy_start]).to include "can't be blank"
    end
    it 'validated the presence of cal start date' do
      expect(@report.errors.messages[:cal_start]).to include "can't be blank"
    end
    it 'validated the presence of pd start date' do
      expect(@report.errors.messages[:pd_start]).to include "can't be blank"
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
# rubocop:enable  Metrics/BlockLength
