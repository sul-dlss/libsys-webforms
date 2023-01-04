require 'rails_helper'

RSpec.describe Sal3BatchRequestsBatch do
  it 'has a valid factory' do
    expect(create(:sal3_batch_requests_batch)).to be_valid
  end

  it 'Defines delivery locations' do
    expect(described_class.locations).to include('Data Control' => 'DC',
                                                 'Redwood City (Special Collections materials)' => 'RW',
                                                 'Archive of Recorded Sound' => 'DA',
                                                 'Redwood City (Archive of Recorded Sound materials)' => 'RA',
                                                 'Earth Sciences' => 'DE',
                                                 'Preservation - Book Repair' => 'BR',
                                                 'Green Loading Dock' => 'DS',
                                                 'Acquisitions' => 'AQ')
  end

  it 'Defines a batch_media hash' do
    expect(described_class.batch_media).to include(book: %w[BOOK Book], unknown: %w[UNKNOWN Unknown])
  end

  it 'Defines a batch_container hash' do
    expect(described_class.batch_container).to include('Manuscript Box' => 'MANUSCRIPT_BOX',
                                                       'Record Storage Boxes' => 'RECORD_BOX',
                                                       'Other Box Type' => 'OTHER_BOX',
                                                       'Unknown' => 'UNKNOWN')
  end

  it 'Defines a status array' do
    expect(described_class.status).to eq %w[NEW APPROVED SUSPENDED REJECTED]
  end

  it 'Defines a priority array' do
    expect(described_class.priority).to eq %w[1 2 3]
  end

  it 'Validates the presence of needed dates' do
    request = described_class.new(batch_startdate: nil, batch_needbydate: nil)
    expect(request).not_to be_valid
  end

  it 'Validates the needed date is not in the past' do
    request = described_class.new(batch_startdate: Time.zone.today, batch_needbydate: Time.zone.yesterday)
    expect(request).not_to be_valid
  end

  it 'Validates the presense of User ID for charge' do
    request = described_class.new(pseudo_id: nil)
    expect(request).not_to be_valid
  end

  it 'Validates that pull days are present' do
    request = described_class.new
    expect(request).not_to be_valid
  end

  it 'Adds an error when no pull days are not present' do
    request = described_class.new
    request.valid?
    expect(request.errors.messages[:base]).to include('Please pick at least one day for items to be delivered.')
  end

  it 'Has an uploader mount' do
    obj = described_class.new
    expect(obj.uploader.instance_variable_get(:@mounted_as)).to eq 'bc_file'
  end

  it 'Has an uploader model' do
    obj = described_class.new
    expect(obj.uploader.instance_variable_get(:@model).class.to_s.underscore).to eq 'sal3_batch_requests_batch'
  end
end
