require 'rails_helper'

describe 'Endowed Funds Reports Page', type: :feature do
  before do
    visit new_endowed_funds_report_path
  end

  it 'renders the hidden field for date_request' do
    attribute = page.find('#endowed_funds_report_date_request', visible: false).value
    expect(attribute).to eq Time.now.getlocal.strftime('%Y-%m-%d %H:%M:%S')
  end
end
