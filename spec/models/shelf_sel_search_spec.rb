require 'rails_helper'

RSpec.describe ShelfSelSearch, type: :model do
  describe 'ShelfSelSearch' do
    it 'has a valid factory' do
      expect(FactoryBot.create(:shelf_sel_search)).to be_valid
    end

    describe '#saved_cursors' do
      it 'returns array of saved cursors' do
        FactoryBot.create(:shelf_sel_search)
        expect(described_class.saved_cursors('mahmed')).to eq(['Green Stacks E-F, mahmed'])
      end
    end

    describe '#call_lo' do
      it 'returns the low bound of call_range' do
        shelf_sel_search = FactoryBot.create(:shelf_sel_search)
        expect(shelf_sel_search.call_lo).to eq('E')
      end
    end

    describe '#call_hi' do
      it 'returns the hi bound of call_range' do
        shelf_sel_search = FactoryBot.create(:shelf_sel_search)
        expect(shelf_sel_search.call_hi).to eq('F')
      end
    end

    describe 'save_search class method' do
      it 'creates a ShelfSelSearch from ShelfSelRpt params' do
        shelf_selection_report = FactoryBot.build(:shelf_selection_report)
        shelf_sel_search = described_class.save_search(shelf_selection_report)
        expect(shelf_sel_search).to be_instance_of(described_class)
      end
    end

    describe 'update_search class method' do
      it 'updates a ShelfSelSearch from ShelfSelRpt params' do
        shelf_selection_report = FactoryBot.build(:shelf_selection_report)
        described_class.save_search(shelf_selection_report)
        described_class.update_search(shelf_selection_report)
      end
    end
  end
end
