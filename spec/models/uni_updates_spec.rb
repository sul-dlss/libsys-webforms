require 'rails_helper'

RSpec.describe UniUpdates do
  it 'has a valid factory' do
    expect(create(:uni_updates)).to be_valid
  end

  it 'separates unique ids from dups' do
    # assuming 123 is unique and 9999 isn't
    allow(described_class).to receive(:filter_duplicates).with(%w[123 9999]).and_return([['123'], ['9999']])
    expect(described_class.filter_duplicates(%w[123 9999])).to eq([['123'], ['9999']])
  end
end
