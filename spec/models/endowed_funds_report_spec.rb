require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe EndowedFundsReport, type: :model do
  describe 'querying specific funds from expenditures' do
    before do
      %w(123 456 789).each do |ckey|
        create(:expenditures, ol_cat_key: ckey)
      end
    end

    let(:report) do
      described_class.new(fund: %w(1065089-103-AABNK), fy_start: 'FY 2010', fy_end: 'FY 2011')
    end

    it 'retrieves a set of catalog keys' do
      expect(report.keys.size).to be 3
    end
  end

  describe 'querying a partial fund name' do
    before do
      FactoryBot.reload
      %w(123 456 789).each do |ckey|
        create(:expenditures, ol_cat_key: ckey)
      end
    end

    let(:report) do
      described_class.new(fund_begin: '1065089-103-', fy_start: 'FY 2010', fy_end: 'FY 2011')
    end

    it 'retrieves a set of catalog keys' do
      expect(report.keys.size).to be 3
    end
  end

  describe 'querying all SUL funds' do
    before do
      FactoryBot.reload
      %w(123 456 789).each do |ckey|
        create(:expenditures, ol_cat_key: ckey, ta_fund_code: 'All SUL Funds')
      end
    end

    let(:report) do
      described_class.new(fund_begin: 'All SUL Funds', fy_start: 'FY 2010', fy_end: 'FY 2011')
    end

    it 'retrieves a set of catalog keys' do
      expect(report.keys.size).to be 3
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

  describe 'invalid statements' do
    before do
      instance = instance_double(described_class)
      allow(instance).to receive(:ol_cat_key_fund_query).and_return(ActiveRecord::StatementInvalid)
    end

    let(:report) do
      described_class.new(fund_begin: 'All SUL Funds', fy_start: 'FY 2010', fy_end: 'FY 2011')
    end

    it 'returns empty' do
      expect(report.keys.size).to be 0
    end
  end

  describe 'validations' do
    before do
      @report = described_class.new(email: '', fund_begin: nil, fund: nil, fy_start: nil, cal_start: nil, pd_start: nil)
      @report.validate
    end

    it 'validated the presence of a date' do
      expect(@report.errors.messages[:base]).to include 'Choose a start date for fiscal, calendar, or paid date'
    end

    it 'validates the presence of a fund' do
      expect(@report.errors.messages[:base]).to include \
        'Select a single Fund ID/PTA, a fund that begins with an ID/PTA number, or all SUL funds'
    end

    it 'validates the email address' do
      expect(@report.errors.messages[:base]).to include 'Email address is missing or not in a correct format'
    end
  end
end
# rubocop:enable Metrics/BlockLength
