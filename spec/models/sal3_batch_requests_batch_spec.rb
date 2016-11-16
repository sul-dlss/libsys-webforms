require 'rails_helper'

RSpec.describe Sal3BatchRequestsBatch, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:sal3_batch_requests_batch)).to be_valid
  end
  it 'Defines delivery locations' do
    expect(Sal3BatchRequestsBatch.locations).to include('Green' => 'GB')
  end
  it 'Defines a batch_media hash' do
    expect(Sal3BatchRequestsBatch.batch_media).to include(book: %w(BOOK Book), unknown: %w(UNKNOWN Unknown))
  end
  it 'Defines a batch_container hash' do
    expect(Sal3BatchRequestsBatch.batch_container).to include('Manuscript Box',
                                                              'Record Storage Boxes',
                                                              'Other Box Type',
                                                              'Unknown')
  end
  it 'Defines a status array' do
    expect(Sal3BatchRequestsBatch.status).to eq %w(NEW APPROVED SUSPENDED REJECTED)
  end
  it 'Defines a priority array' do
    expect(Sal3BatchRequestsBatch.priority). to eq %w(1 2 3)
  end
end
