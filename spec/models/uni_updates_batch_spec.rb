require 'rails_helper'

RSpec.describe UniUpdatesBatch, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:authorized_user)).to be_valid
  end
end
