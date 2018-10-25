require 'rails_helper'

RSpec.describe Sal3BatchRequestsBatch, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:sal3_batch_requests_batch)).to be_valid
  end
  it 'Defines delivery locations' do
    expect(Sal3BatchRequestsBatch.locations).to include('Data Control' => 'DC',
                                                        'Redwood City (Special Collections materials)' => 'RW',
                                                        'Archive of Recorded Sound' => 'DA',
                                                        'Redwood City (Archive of Recorded Sound materials)' => 'RA',
                                                        'Earth Sciences' => 'DE',
                                                        'Preservation - Book Repair' => 'BR',
                                                        'Green Loading Dock' => 'DS',
                                                        'Acquisitions' => 'AQ')
  end
  it 'Defines a batch_media hash' do
    expect(Sal3BatchRequestsBatch.batch_media).to include(book: %w[BOOK Book], unknown: %w[UNKNOWN Unknown])
  end
  it 'Defines a batch_container hash' do
    expect(Sal3BatchRequestsBatch.batch_container).to include('Manuscript Box' => 'MANUSCRIPT_BOX',
                                                              'Record Storage Boxes' => 'RECORD_BOX',
                                                              'Other Box Type' => 'OTHER_BOX',
                                                              'Unknown' => 'UNKNOWN')
  end
  it 'Defines a status array' do
    expect(Sal3BatchRequestsBatch.status).to eq %w[NEW APPROVED SUSPENDED REJECTED]
  end
  it 'Defines a priority array' do
    expect(Sal3BatchRequestsBatch.priority). to eq %w[1 2 3]
  end
  it 'Validates the presence of needed dates' do
    request = Sal3BatchRequestsBatch.new(batch_startdate: nil, batch_needbydate: nil)
    expect(request).to_not be_valid
  end
  it 'Validates the presense of User ID for charge' do
    request = Sal3BatchRequestsBatch.new(pseudo_id: nil)
    expect(request).to_not be_valid
  end
  it 'Adds an error when at least one pull day is not present' do
    request = Sal3BatchRequestsBatch.new(batch_pullfri: nil,
                                         batch_pullthurs: nil,
                                         batch_pullwed: nil,
                                         batch_pulltues: nil,
                                         batch_pullmon: nil)
    expect(request).to_not be_valid
    expect(request.errors.full_messages).to include('Please pick at least one day for items to be delivered.')
  end
  it 'Has an uploader mount' do
    obj = Sal3BatchRequestsBatch.new
    expect(obj.uploader.instance_variable_get(:@mounted_as)).to eq 'bc_file'
    expect(obj.uploader.instance_variable_get(:@model).class.to_s.underscore).to eq 'sal3_batch_requests_batch'
  end
end
