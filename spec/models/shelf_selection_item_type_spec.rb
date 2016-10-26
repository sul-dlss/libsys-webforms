require 'rails_helper'

RSpec.describe ShelfSelectionItemType, type: :model do
  describe 'ShelfSelectionItemType' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:shelf_selection_item_type)).to be_valid
    end

    it 'returns a list of item types' do
      FactoryGirl.create(:shelf_selection_item_type)
      expect(ShelfSelectionItemType.item_types).to eq(['ATLAS', 'All Item Types'])
    end
  end
end
