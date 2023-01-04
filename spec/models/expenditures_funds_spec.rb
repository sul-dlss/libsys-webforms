require 'rails_helper'

RSpec.describe ExpendituresFunds do
  let(:funds_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('files/expenditures_funds.csv', 'text/plain')
  end

  it 'has a valid factory' do
    expect(create(:expenditures_funds)).to be_valid
  end

  it 'supplies a table of funds' do
    expect(described_class.fund_id).to be_a(ActiveRecord::Relation)
  end

  it 'supplies a table of funds_beginning_with' do
    expect(described_class.fund_begins_with).to be_a(ActiveRecord::Relation)
  end
end
