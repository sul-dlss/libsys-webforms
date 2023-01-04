require 'rails_helper'

RSpec.describe ShelfSelectionReport do
  describe 'ShelfSelectionReport' do
    it 'returns generic options for selects' do
      expect(described_class.generic_options).to eq([["Doesn't matter", 0], ['INCLUDE only', 1], ['EXCLUDE', 2]])
    end

    it 'validates lo and hi call numbers' do
      shelf_selection_report = described_class.new(email: 'test@test.org', range_type: 'classic')
      message = ['Low and hi callnum range must be all digits, with lo lower than hi.']
      expect(shelf_selection_report.send(:classic_call_lo_and_hi)).to eq(message)
    end
  end
end
