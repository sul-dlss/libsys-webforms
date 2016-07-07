require 'rails_helper'

RSpec.describe EncumbranceReport, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:encumbrance_report)).to be_valid
  end
  it 'Defines a list of fund cycles' do
    expect(EncumbranceReport.fundcyc_cycle).to include('2015', '9899', '9798', '9697')
  end

  describe 'callbacks' do
    before do
      @report = FactoryGirl.create(:encumbrance_report)
    end
    it 'sets the attribute for fund_acct with a fund_begin value' do
      @report.update_attribute(:fund, nil)
      expect(@report.send(:set_fund)).to eq('1065032-103-')
    end
  end
end
