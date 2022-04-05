require 'rails_helper'

RSpec.describe ShelfSelItemCat1, type: :model do
  it 'has a valid factory' do
    expect(create(:shelf_sel_item_cat1)).to be_valid
  end

  it 'returns array of item category1s' do
    create(:shelf_sel_item_cat1)
    expect(described_class.item_category1s).to eq(['All Item Category1s', 'BUSCORPRPT'])
  end
end
