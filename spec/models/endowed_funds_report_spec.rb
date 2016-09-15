require 'rails_helper'

RSpec.describe EndowedFundsReport, type: :model do
  describe 'querying from expenditures' do
    it 'should retrieve a set of catalog keys' do
      @endow_funds = FactoryGirl.create(:expenditures)
      expect(@endow_funds.ol_cat_key).to eq('1234567')
      expect(EndowedFundsReport.ol_cat_key(@endow_funds.ta_fund_code)).to be_kind_of(Array)
    end
  end
end
