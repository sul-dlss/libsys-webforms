require 'rails_helper'

RSpec.describe ShelfSelectionItemType do
  describe 'ShelfSelectionItemType' do
    it 'has a valid factory' do
      expect(create(:shelf_selection_item_type)).to be_valid
    end

    it 'returns a list of item types' do
      create(:shelf_selection_item_type)
      expect(described_class.item_types).to eq(['All Item Types', 'ATLAS'])
    end
  end
end
