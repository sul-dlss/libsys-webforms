require 'rails_helper'

RSpec.describe UniUpdatesBatch do
  it 'has a valid factory' do
    expect(create(:uni_updates_batch)).to be_valid
  end
end
