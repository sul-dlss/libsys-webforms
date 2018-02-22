require 'rails_helper'

describe 'sal3_batch_requests_batches' do
  before { stub_current_user(FactoryBot.create(:authorized_user)) }
  before(:each) { visit sal3_batch_requests_batches_path }

  it 'display the button links to filter the scope by pull day' do
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches"]')
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pullmon=1"]')
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pulltues=1"]')
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pullwed=1"]')
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pullthurs=1"]')
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pullfri=1"]')
  end

  it 'display the table of batch requests submitted' do
    expect(page).to have_text('SAL3 Batch Requests')
    expect(page).to have_css('th', text: 'Date needed')
    expect(page).to have_css('th', text: 'Name or short description')
    expect(page).to have_css('th', text: 'Stop code')
    expect(page).to have_css('th', text: 'No. of items requested')
    expect(page).to have_css('th', text: 'Status')
    expect(page).to have_css('th', text: 'Multiple pulls for batch?')
    expect(page).to have_css('th', text: 'Date requested')
  end
end
