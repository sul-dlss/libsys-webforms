require 'rails_helper'

RSpec.describe UniLibsLocs, type: :model do
  describe 'UniLibsLocs' do
    it 'has a valid factory' do
      expect(create(:uni_libs_locs)).to be_valid
    end

    it 'returns an array of library names' do
      create(:uni_libs_locs)
      expect(described_class.libraries).to eq(%w[SAL3])
    end

    it 'returns an array of home locations given a library' do
      create(:uni_libs_locs)
      expect(described_class.home_locations_from('SAL3')).to eq(['PAGE-MU'])
    end
  end
end
