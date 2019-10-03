require 'rails_helper'

describe 'Packages List Transfer Logs', type: :feature do
  before do
    stub_current_user(FactoryBot.create(:admin_user))
    FactoryBot.create(:vnd_runlog)
    FactoryBot.create(:vnd_runlog_info)
    visit list_transfer_logs_packages_path
  end

  it 'displays a page heading' do
    expect(page).to have_css('h1', text: 'List and transfer logs for active packages')
  end

  it 'displays two log entries for Run date/time' do
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Run date/time', count: 2)
  end

  it 'displays two log entries for Procedure name' do
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Procedure name', count: 2)
  end

  it 'displays two log entries for Message' do
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Message', count: 2)
  end

  it 'displays two log entries for Vendor name' do
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Vendor name', count: 2)
  end

  it 'displays two log entries for Action type' do
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Action type', count: 2)
  end

  it 'displays two log entries for File name' do
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'File name', count: 2)
  end

  it 'displays two log entries for Note' do
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Note', count: 2)
  end

  it 'displays some data, ex 1' do
    expect(page).to have_css('table>tbody>tr>td', text: 'VND_GET_GEN_FILES_LIST')
  end

  it 'displays some data, ex 2' do
    expect(page).to have_css('table>tbody>tr>td', text: 'sp_20181121131154_afs')
  end

  it 'displays some data, ex 3' do
    expect(page).to have_css('table>tbody>tr>td', text: '(sp) OCLC WorldCat Collection Sets')
  end
end
