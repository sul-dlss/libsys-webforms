require 'rails_helper'

RSpec.describe Expenditures do
  describe 'querying from expenditures' do
    before do
      @expenditures = create(:expenditures)
    end

    it 'retrieves a set of fund codes' do
      expect(@expenditures.ta_fund_code).to eq('1065089-103-AABNK')
    end
  end
end
