require 'rails_helper'

RSpec.describe ShelfSelectionReport, type: :model do
  describe 'ShelfSelectionReport' do
    it 'returns generic options for selects' do
      expect(ShelfSelectionReport.generic_options).to eq([["Doesn't matter", 0], ['INCLUDE only', 1], ['EXCLUDE', 2]])
    end
  end
end
