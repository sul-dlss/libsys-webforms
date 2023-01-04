require 'rails_helper'

RSpec.describe SsdsRequest do
  let(:ssds) { described_class.new(ssds_request_params) }

  let(:ssds_request_params) do
    {
      title_in: 'School for Gifted Youngsters',
      unicorn_id_in: '510163',
      name: 'Jean Grey',
      phone: '650-123-4567',
      sunet: 'sunet_id',
      dataset_type: 'TAPE',
      department: 'Sociology',
      affiliation: 'Staff',
      sponsor: 'Professor X',
      call_no_in: 'TAPE NO. AS1999 ETC',
      notes: 'note'
    }
  end

  describe 'affiliations' do
    it 'is an array of affiliation names' do
      expect(ssds.affiliations).to eq %w(Other Faculty Graduate Staff Undergraduate)
    end
  end

  describe 'departments' do
    it 'is an array of department names' do
      expect(ssds.departments).to include 'Computer Science'
    end
  end

  describe 'datasets' do
    it 'is an array of dataset types' do
      expect(ssds.datasets).to eq %w[Other TAPE ICPSR ROPER]
    end
  end

  describe 'dataset_default' do
    it 'returns a default dataset type TAPE based on the call number text' do
      expect(ssds.dataset_default).to eq 'TAPE'
    end

    it 'returns a default dataset type ICPSR based on the call number text' do
      params = ssds_request_params.merge(call_no_in: 'ICPSR ...')
      expect(described_class.new(params).dataset_default).to eq 'ICPSR'
    end

    it 'returns a default dataset type ROPER based on the call number text' do
      params = ssds_request_params.merge(call_no_in: 'ROPER ...')
      expect(described_class.new(params).dataset_default).to eq 'ROPER'
    end

    it 'returns a default dataset type Other if there is no call number text' do
      params = ssds_request_params.merge(call_no_in: nil)
      expect(described_class.new(params).dataset_default).to eq 'Other'
    end
  end

  describe 'validation of required :call_no_in, :title_in, :unicorn_id_in' do
    it 'is valid if all required params are present' do
      expect(ssds).to be_valid
    end

    it 'is invalid if :title_in is missing' do
      invalid_params = ssds_request_params.merge(title_in: nil)
      expect(described_class.new(invalid_params)).to be_invalid
    end

    it 'is invalid if :call_no_in is missing' do
      invalid_params = ssds_request_params.merge(call_no_in: nil)
      expect(described_class.new(invalid_params)).to be_invalid
    end

    it 'is invalid if :unicorn_id_in is missing' do
      invalid_params = ssds_request_params.merge(unicorn_id_in: nil)
      expect(described_class.new(invalid_params)).to be_invalid
    end
  end
end
