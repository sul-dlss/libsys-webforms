require 'rails_helper'

RSpec.describe ShelfSelItemCat1, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:shelf_sel_item_cat1)).to be_valid
  end

  it 'returns array of item category1s' do
    FactoryGirl.create(:shelf_sel_item_cat1)
    expect(ShelfSelItemCat1.item_category1s).to eq(['BUSCORPRPT'])
  end
end
