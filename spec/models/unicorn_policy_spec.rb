require 'rails_helper'

RSpec.describe UnicornPolicy do
  it 'has a valid factory' do
    expect(create(:unicorn_policy)).to be_valid
  end

  it 'returns libraries' do
    create(:unicorn_policy)
    expect(described_class.libraries.first.type).to eq('LIBR')
  end

  it 'returns itypes' do
    create(:unicorn_policy, type: 'ITYP')
    expect(described_class.item_types.first.type).to eq('ITYP')
  end

  it 'returns locations' do
    create(:unicorn_policy, type: 'LOCN')
    expect(described_class.locations.first.type).to eq('LOCN')
  end
end
