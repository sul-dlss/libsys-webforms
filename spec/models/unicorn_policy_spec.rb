require 'rails_helper'

RSpec.describe UnicornPolicy, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:unicorn_policy)).to be_valid
  end

  it 'returns libraries' do
    FactoryGirl.create(:unicorn_policy)
    expect(UnicornPolicy.libraries.first.type).to eq('LIBR')
  end

  it 'returns itypes' do
    FactoryGirl.create(:unicorn_policy, type: 'ITYP')
    expect(UnicornPolicy.item_types.first.type).to eq('ITYP')
  end

  it 'returns locations' do
    FactoryGirl.create(:unicorn_policy, type: 'LOCN')
    expect(UnicornPolicy.locations.first.type).to eq('LOCN')
  end
end
