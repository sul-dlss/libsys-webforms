require 'rails_helper'

RSpec.describe ChangeItemType do
  describe '#parse_uploaded_file' do
    let(:barcode_file) do
      extend ActionDispatch::TestProcess
      fixture_file_upload('files/test_file.txt', 'text/plain')
    end

    it 'returns an array from a string of ids' do
      change_item_type = described_class.new
      change_item_type.item_ids = barcode_file
      expect(change_item_type.parse_uploaded_file).to be_a(Array)
    end
  end
end
