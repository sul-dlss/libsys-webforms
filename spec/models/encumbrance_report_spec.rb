require 'rails_helper'

RSpec.describe EncumbranceReport, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:encumbrance_report)).to be_valid
  end

  it 'Defines a list of fund cycles' do
    expect(fiscal_years).to include('2015', '9899', '9798', '9697')
  end

  describe 'callbacks' do
    before do
      @report = FactoryBot.create(:encumbrance_report)
    end

    it 'sets the attribute for fund_acct with a fund_begin value' do
      @report.update(fund: nil)
      expect(@report.send(:set_fund)).to eq('1065032-103-')
    end
  end

  describe 'validations' do
    before do
      @report = described_class.new(email: nil,
                                    fund_begin: nil,
                                    fund: nil,
                                    status: nil,
                                    output_file: nil,
                                    date_request: nil)
      @report.valid?
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
    it 'validates presence of request_date' do
      expect(@report.errors.messages[:date_request]).to include "can't be blank"
    end
    it 'validates presence of status' do
      expect(@report.errors.messages[:status]).to include "can't be blank"
    end
    it 'validates presence of output_file' do
      expect(@report.errors.messages[:output_file]).to include "can't be blank"
    end
  end
end
