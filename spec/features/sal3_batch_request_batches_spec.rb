require 'rails_helper'

describe 'Sal3 Batch Requests Batch Page', type: :feature do
  before do
    stub_current_user(FactoryBot.create(:authorized_user))
    visit sal3_batch_requests_batches_path
  end

  it 'display the button links to filter the scope by all pull days' do
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches"]')
  end

  it 'display the button links to filter the scope to pullmon' do
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pullmon=1"]')
  end

  it 'display the button links to filter the scope to pulltues' do
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pulltues=1"]')
  end

  it 'display the button links to filter the scope to pullwed' do
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pullwed=1"]')
  end

  it 'display the button links to filter the scope to pullthurs' do
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pullthurs=1"]')
  end

  it 'display the button links to filter the scope to pullfri' do
    expect(page).to have_selector(:css, 'a[href="/sal3_batch_requests_batches?pullfri=1"]')
  end

  describe 'table of batch requests submitted' do
    let(:headers) do
      /(Date needed
        |Name or short description
        |Stop code
        |No. of items requested
        |Status
        |Multiple pulls for batch\?
        |Date requested)/x
    end

    it 'displays a page title' do
      expect(page).to have_text('SAL3 Batch Requests')
    end

    it 'displays several table headers' do
      expect(page).to have_css('th', text: headers)
    end
  end

  describe 'selection of status filters' do
    let(:selections) do
      /(ALL|NEW|APPROVED|REJECTED|SUSPENDED|DONE)/
    end

    it 'display the' do
      expect(page).to have_css('option', text: selections)
    end
  end
end
