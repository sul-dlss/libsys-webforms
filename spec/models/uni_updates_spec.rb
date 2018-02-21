require 'rails_helper'

RSpec.describe UniUpdates, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:uni_updates)).to be_valid
  end

  it 'separates unique ids from dups' do
    # assuming 123 is unique and 9999 isn't
    allow(UniUpdates).to receive(:filter_duplicates).with(%w[123 9999]).and_return([['123'], ['9999']])
    expect(UniUpdates.filter_duplicates(%w[123 9999])).to eq([['123'], ['9999']])
  end
end
