require 'rails_helper'

RSpec.describe ChangeHomeLocation, type: :model do
  describe '#parse_uploaded_file' do
    let(:barcode_file) do
      extend ActionDispatch::TestProcess
      fixture_file_upload('files/test_file.txt', 'text/plain')
    end

    it 'returns an array from a string of ids' do
      change_home_location = described_class.new
      change_home_location.item_ids = barcode_file
      expect(change_home_location.parse_uploaded_file).to be_kind_of(Array)
    end
    it 'accepts a valid email_pattern' do
      change_home_location = described_class.new(email: 'vtang@stanford.edu, rtamares@law.stanford.edu',
                                                 current_library: 'GREEN',
                                                 new_home_location: 'STACKS',
                                                 item_ids: barcode_file)
      expect(change_home_location).to be_valid
    end
    it 'rejects an invalid email_pattern' do
      change_home_location = described_class.new(email: 'vtang@stanford rtamares-.stanford.edu',
                                                 current_library: 'GREEN',
                                                 new_home_location: 'STACKS',
                                                 item_ids: barcode_file)
      expect(change_home_location).not_to be_valid
    end
  end
end
