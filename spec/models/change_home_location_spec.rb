require 'rails_helper'

RSpec.describe ChangeHomeLocation, type: :model do
  describe '#parse_uploaded_file' do
    let(:barcode_file) do
      extend ActionDispatch::TestProcess
      fixture_file_upload('files/test_file.txt', 'text/plain')
    end
    it 'returns an array from a string of ids' do
      change_home_location = ChangeHomeLocation.new
      change_home_location.item_ids = barcode_file
      expect(change_home_location.parse_uploaded_file).to be_kind_of(Array)
    end
  end
end
