require 'rails_helper'

RSpec.describe AccessionNumber do
  it 'has a valid factory' do
    expect(create(:accession_number)).to be_valid
  end
end
