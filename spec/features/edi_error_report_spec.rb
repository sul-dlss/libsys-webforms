require 'rails_helper'

describe 'Edi Error Reports', type: :feature do
  before do
    stub_current_user(create(:authorized_user))
    visit edi_error_reports_path
  end

  let(:headers) do
    /(Run|Type|Error|Error level)/
  end

  it 'display a button to the main menu' do
    expect(page).to have_selector(:css, 'a[href="/"]')
  end

  it 'display a button to the EDI menu' do
    expect(page).to have_selector(:css, 'a[href="/edi_invoices/menu"]')
  end

  it 'displays the table of batch requests submitted' do
    expect(page).to have_text('EDIFACT invoice errors')
  end

  it 'display the table headers for batch requests submitted' do
    expect(page).to have_css('th', text: headers)
  end

  it 'displays the button to show all errors for the day' do
    expect(page).to have_link('Show errors for today', href: "/edi_error_reports?day=#{Time.zone.today.to_date}")
  end

  it 'displays the button to show all errors for all days' do
    expect(page).to have_link('Show all errors for all days', href: '/edi_error_reports')
  end
end
