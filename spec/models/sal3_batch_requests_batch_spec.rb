require 'rails_helper'

RSpec.describe Sal3BatchRequestsBatch, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.create(:sal3_batch_requests_batch)).to be_valid
  end
  it 'Defines delivery locations' do
    expect(Sal3BatchRequestsBatch.locations).to include('Data Control' => 'DC',
                                                        'Special Collections - Redwood City' => 'RW',
                                                        'Archive of Recorded Sound' => 'DA',
                                                        'Archive of Recorded Sound - Redwood City' => 'RA',
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
    request = FactoryBot.build(:sal3_batch_requests_batch, batch_startdate: nil, batch_needbydate: nil)
    expect(request).not_to be_valid
  end
end
