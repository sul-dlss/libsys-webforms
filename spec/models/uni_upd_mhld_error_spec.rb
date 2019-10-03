require 'rails_helper'

RSpec.describe UniUpdMhldError, type: :model do
  describe 'errors_for_mhld' do
    batch_errors = FactoryBot.create(:uni_upd_mhld_error)

    it 'returns a batch_id table row for the given batch id' do
      expect(batch_errors.batch_id).to eq 247_89
    end

    it 'returns a flex id table row for the given batch id' do
      expect(batch_errors.flex).to eq 'APG1285'
    end

    it 'returns an error message table row for the given batch id' do
      expect(batch_errors.err_msg).to eq 'serial ctrl'
    end

    it 'returns a format table row for the given batch id' do
      expect(batch_errors.format).to eq 'SERIAL'
    end

    it 'returns an old lib table row for the given batch id' do
      expect(batch_errors.old_lib).to eq 'SAL3'
    end

    it 'returns a new lib table row for the given batch id' do
      expect(batch_errors.new_lib).to eq 'SAL3'
    end

    it 'returns a new loc table row for the given batch id' do
      expect(batch_errors.new_loc).to eq 'STACKS'
    end
  end
end
