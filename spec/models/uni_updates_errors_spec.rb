require 'rails_helper'

describe UniUpdatesErrors do
  describe 'errors_for_batch' do
    batch_errors = create(:errors_for_batch)

    it 'returns a datetime table row for the given batch id' do
      expect(batch_errors.run).to eq '2013-06-15 12:06:35'
    end

    it 'returns a batch id table row for the given batch id' do
      expect(batch_errors.batch).to eq '12845'
    end

    it 'returns a barcode table row for the given batch id' do
      expect(batch_errors.item_id).to eq '36105134493878'
    end

    it 'returns a call number table row for the given batch id' do
      expect(batch_errors.call_num).to eq 'HE2791 .D63 A2 1940'
    end

    it 'returns a shelving key table row for the given batch id' do
      expect(batch_errors.shelving_key).to eq 'HE 002791 .D63 A2 001940'
    end

    it 'returns a message table row for the given batch id' do
      expect(batch_errors.msg).to eq 'some-message'
    end
  end
end
