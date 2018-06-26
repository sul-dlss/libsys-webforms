require 'rails_helper'

describe 'edi_incoices' do
  before { stub_current_user(FactoryBot.create(:authorized_user)) }
  before(:each) { visit edi_invoices_path }

  it 'display a button to the main menu' do
    expect(page).to have_selector(:css, 'a[href="/"]')
  end

  it 'display a button to the EDI menu' do
    expect(page).to have_selector(:css, 'a[href="/edi_invoices/menu"]')
  end

  it 'display the table of batch requests submitted' do
    expect(page).to have_text('EDIFACT invoice management')
    expect(page).to have_css('th', text: 'Invoice Number')
    expect(page).to have_css('th', text: 'Vendor ID')
    expect(page).to have_css('th', text: 'Vendor Invoice Date')
    expect(page).to have_css('th', text: 'Status')
    expect(page).to have_css('th', text: 'Symphony Invoice Date Created')
    expect(page).to have_css('th', text: 'Total Pieces')
  end

  it 'display the selection of status filters' do
    expect(page).to have_css('option', text: 'ALL')
    expect(page).to have_css('option', text: 'YANKEE')
    expect(page).to have_css('option', text: 'COUTTS')
    expect(page).to have_css('option', text: 'CASALI')
    expect(page).to have_css('option', text: 'AMALIV')
    expect(page).to have_css('option', text: 'HARRAS')
  end
end
