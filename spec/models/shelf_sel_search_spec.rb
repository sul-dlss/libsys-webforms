require 'rails_helper'

RSpec.describe ShelfSelSearch, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:shelf_sel_search)).to be_valid
  end

  it 'returns array of saved cursors' do
    FactoryGirl.create(:shelf_sel_search)
    expect(ShelfSelSearch.saved_cursors('mahmed')).to eq(['Green Stacks E-F, mahmed'])
  end
end
