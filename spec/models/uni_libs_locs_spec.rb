require 'rails_helper'

RSpec.describe UniLibsLocs, type: :model do
  describe 'UniLibsLocs' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:uni_libs_locs)).to be_valid
    end

    it 'returns an array of library names' do
      FactoryGirl.create(:uni_libs_locs)
      expect(UniLibsLocs.libraries).to eq(%w(ALL SAL3))
    end

    it 'returns an array of home locations given a library' do
      FactoryGirl.create(:uni_libs_locs)
      expect(UniLibsLocs.home_locations_from('SAL3')).to eq(['PAGE-MU'])
    end
  end
end
