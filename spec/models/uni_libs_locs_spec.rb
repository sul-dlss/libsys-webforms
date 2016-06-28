require 'rails_helper'

RSpec.describe UniLibsLocs, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:uni_libs_locs)).to be_valid
  end

  it 'returns an array of library names' do
    FactoryGirl.create(:uni_libs_locs)
    expect(UniLibsLocs.libraries).to eq(['SAL3'])
  end
end
