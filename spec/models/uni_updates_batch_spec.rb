require 'rails_helper'

RSpec.describe UniUpdatesBatch, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:uni_updates_batch)).to be_valid
  end
end
