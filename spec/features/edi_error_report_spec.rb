require 'rails_helper'

describe 'edi_error_reports' do
  before { stub_current_user(FactoryBot.create(:authorized_user)) }
  before(:each) { visit edi_error_reports_path }

  it 'display a button to the main menu' do
    expect(page).to have_selector(:css, 'a[href="/"]')
  end

  it 'display a button to the EDI menu' do
    expect(page).to have_selector(:css, 'a[href="/edi_invoices/menu"]')
  end

  it 'display the table of batch requests submitted' do
    expect(page).to have_text('EDIFACT invoice errors')
    expect(page).to have_css('th', text: 'Run')
    expect(page).to have_css('th', text: 'Type')
    expect(page).to have_css('th', text: 'Error')
    expect(page).to have_css('th', text: 'Error level')
  end

  it 'displays the button to show all errors for the day' do
    expect(page).to have_link('Show errors for today', href: "/edi_error_reports?day=#{Time.zone.today.to_date}")
  end

  it 'displays a date field to show all errors for the day' do
    field = page.find_field('edi_errors_day').value.to_date
    expect(field).to eq(Time.zone.today)
  end

  it 'displays the button to show all errors for all days' do
    expect(page).to have_link('Show all errors for all days', href: '/edi_error_reports')
  end
end
