require 'rails_helper'

RSpec.describe EndowedFundsReport, type: :model do
  before do
    @endow_funds = FactoryGirl.create(:expenditures)
  end
  describe 'querying from expenditures' do
    subject { EndowedFundsReport.ol_cat_key(@endow_funds.ta_fund_code, '2015-07-01', '2016-06-30') }
    it 'should retrieve a set of catalog keys' do
      expect(@endow_funds.ol_cat_key).to eq('1234567')
      expect(subject).to be_kind_of(Array)
    end

    subject { EndowedFundsReport.ol_cat_key(['1000501-1-AACIZ', '1008930-1-HAGOY'], '2015-07-01', '2016-06-30') }
    it 'should initialize a container of fund codes' do
      expect(subject).to be_kind_of(Array)
    end
  end
end
