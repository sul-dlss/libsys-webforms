require 'rails_helper'

RSpec.describe UniUpdMhldError, type: :model do
  describe 'errors_for_mhld' do
    it 'returns some table rows with the given batch id' do
      batch_errors = FactoryBot.create(:uni_upd_mhld_error)
      expect(batch_errors.batch_id).to eq 247_89
      expect(batch_errors.flex).to eq 'APG1285'
      expect(batch_errors.err_msg).to eq 'serial ctrl'
      expect(batch_errors.format).to eq 'SERIAL'
      expect(batch_errors.old_lib).to eq 'SAL3'
      expect(batch_errors.new_lib).to eq 'SAL3'
      expect(batch_errors.new_loc).to eq 'STACKS'
    end
  end
end
