require 'rails_helper'

describe UniUpdatesErrors do
  describe 'errors_for_batch' do
    it 'returns some table rows with the given batch id' do
      batch_errors = FactoryBot.create(:errors_for_batch)

      expect(batch_errors.run).to eq '2013-06-15 12:06:35'
      expect(batch_errors.batch).to eq '12845'
      expect(batch_errors.item_id).to eq '36105134493878'
      expect(batch_errors.call_num).to eq 'HE2791 .D63 A2 1940'
      expect(batch_errors.shelving_key).to eq 'HE 002791 .D63 A2 001940'
      expect(batch_errors.msg).to eq 'some-message'

      expect(UniUpdatesErrors.errors_for_batch('12845')).to be_kind_of(ActiveRecord::Relation)
    end
  end
end
