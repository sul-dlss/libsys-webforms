require 'rails_helper'

describe 'sal3_batch_requests_batches' do
  before { stub_current_user(FactoryBot.create(:authorized_user)) }
  it 'Display the table of batch requests submitted' do
    visit sal3_batch_requests_batches_path
    expect(page).to have_text('SAL3 Batch Requests')
    expect(page).to have_css('th', text: 'Date needed')
    expect(page).to have_css('th', text: 'Name or short description')
    expect(page).to have_css('th', text: 'Stop code')
    expect(page).to have_css('th', text: 'No. of items requested')
    expect(page).to have_css('th', text: 'Status')
    expect(page).to have_css('th', text: 'Multiple requests in batch?')
    expect(page).to have_css('th', text: 'Date requested')
  end
end
