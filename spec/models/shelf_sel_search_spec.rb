require 'rails_helper'

RSpec.describe ShelfSelSearch, type: :model do
  describe 'ShelfSelSearch' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:shelf_sel_search)).to be_valid
    end

    describe '#saved_cursors' do
      it 'returns array of saved cursors' do
        FactoryGirl.create(:shelf_sel_search)
        expect(ShelfSelSearch.saved_cursors('mahmed')).to eq(['Green Stacks E-F, mahmed'])
      end
    end

    describe '#call_lo' do
      it 'returns the low bound of call_range' do
        shelf_sel_search = FactoryGirl.create(:shelf_sel_search)
        expect(shelf_sel_search.call_lo).to eq('E')
      end
    end

    describe '#call_hi' do
      it 'returns the hi bound of call_range' do
        shelf_sel_search = FactoryGirl.create(:shelf_sel_search)
        expect(shelf_sel_search.call_hi).to eq('F')
      end
    end

    describe 'save_search class method' do
      it 'creates a ShelfSelSearch from ShelfSelRpt params' do
        shelf_selection_report = FactoryGirl.build(:shelf_selection_report)
        shelf_sel_search = ShelfSelSearch.save_search(shelf_selection_report)
        expect(shelf_sel_search).to be_instance_of(ShelfSelSearch)
      end
    end
  end
end
