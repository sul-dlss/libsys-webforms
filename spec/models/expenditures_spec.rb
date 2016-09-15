require 'rails_helper'

RSpec.describe Expenditures, type: :model do
  describe 'querying from expenditures' do
    it 'should retrieve a set of fund codes' do
      @expenditures = FactoryGirl.create(:expenditures)
      expect(@expenditures.ta_fund_code).to eq('1065089-103-AABNK')
      expect(Expenditures.ta_fund_code).to be_kind_of(ActiveRecord::Relation)
    end
  end
end
