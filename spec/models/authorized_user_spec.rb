require 'rails_helper'

describe AuthorizedUser do
  it 'has a valid factory' do
    expect(FactoryBot.create(:authorized_user)).to be_valid
  end
end
