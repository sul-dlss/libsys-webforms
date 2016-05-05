require 'rails_helper'

RSpec.describe UniUpdates, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:uni_updates)).to be_valid
  end
end
