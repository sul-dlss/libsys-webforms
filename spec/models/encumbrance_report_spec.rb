require 'rails_helper'

RSpec.describe EncumbranceReport, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:encumbrance_report)).to be_valid
  end
  it 'Defines a list of fund cycles' do
    expect(EncumbranceReport.fundcyc_cycle).to include('2016', '9899', '9798', '9697')
  end
end
