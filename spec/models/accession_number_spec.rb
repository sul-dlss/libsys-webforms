require 'rails_helper'

RSpec.describe AccessionNumber, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:accession_number)).to be_valid
  end
end
