require 'rails_helper'

describe 'Edi Invoices', type: :feature, js: true do
  before do
    stub_current_user(create(:authorized_user))
    visit edi_invoices_path
  end

  let(:headers) do
    /(Invoice Number|Vendoe ID|Vendor Invoice Date|Status|Symphony Invoice Date Created|Total Pieces)/
  end

  let(:statuses) do
    /(ALL|YANKEE|COUTTS|CASALI|AMALIV|HARRAS)/
  end

  it 'display a button to the main menu' do
    expect(page).to have_selector(:css, 'a[href="/"]')
  end

  it 'display a button to the EDI menu' do
    expect(page).to have_selector(:css, 'a[href="/edi_invoices/menu"]')
  end

  it 'display the table of batch requests submitted' do
    expect(page).to have_text('EDIFACT invoices')
  end

  it 'displays table header text' do
    expect(page).to have_css('th', text: headers)
  end

  it 'display the selection of status filters' do
    expect(page).to have_css('option', text: statuses)
  end

  it 'changes the vendor' do
    page.select('YANKEE', from: 'vendor')
    expect(page).not_to have_css('td', text: 'CASALI')
  end
end
