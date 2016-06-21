require 'rails_helper'

RSpec.describe ExpendituresFunds, type: :model do
  let(:funds_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('files/expenditures_funds.csv', 'text/plain')
  end
  it 'has a valid factory' do
    expect(FactoryGirl.create(:expenditures_funds)).to be_valid
  end
  it 'supplies a table of funds' do
    expect(ExpendituresFunds.fund_id).to be_kind_of(ActiveRecord::Relation)
  end
  it 'supplies a table of funds_beginning_with' do
    expect(ExpendituresFunds.fund_begins_with).to be_kind_of(ActiveRecord::Relation)
  end
end
