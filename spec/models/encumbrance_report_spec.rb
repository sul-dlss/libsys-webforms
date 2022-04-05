require 'rails_helper'

RSpec.describe EncumbranceReport, type: :model do
  it 'has a valid factory' do
    expect(create(:encumbrance_report)).to be_valid
  end

  it 'Defines a list of fund cycles' do
    expect(fiscal_years).to include('2015', '9899', '9798', '9697')
  end

  describe 'callbacks' do
    before do
      @report = create(:encumbrance_report)
    end

    it 'sets the attribute for fund_acct with a fund_begin value' do
      @report.update(fund: nil)
      expect(@report.send(:set_fund)).to eq('1065032-103-')
    end
  end

  describe 'validations' do
    before do
      @report = build(:encumbrance_report,
                      email: '', fund_begin: nil, fund: nil)
      @report.validate
    end

    it 'validates the presence of an email address' do
      expect(@report.errors.messages[:base]).to include 'Email address is missing or not in a correct format'
    end

    it 'validates the presence of a fund' do
      expect(@report.errors.messages[:base]).to include \
        'Select a single Fund ID/PTA, a fund that begins with an ID/PTA number, or all SUL funds'
    end
  end
end
