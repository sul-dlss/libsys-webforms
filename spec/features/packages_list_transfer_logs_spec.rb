require 'rails_helper'

describe 'packages list transfer logs' do
  before(:each) do
    stub_current_user(FactoryBot.create(:admin_user))
    @vnd_runlog = FactoryBot.create(:vnd_runlog)
    @vnd_runlog_info = FactoryBot.create(:vnd_runlog_info)
    visit list_transfer_logs_packages_path
  end

  it 'should display a page heading' do
    expect(page).to have_css('h1', text: 'List and transfer logs for active packages')
  end
  it 'should display two log entries' do
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Run date/time', count: 2)
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Procedure name', count: 2)
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Message', count: 2)
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Vendor name', count: 2)
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Action type', count: 2)
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'File name', count: 2)
    expect(page).to have_css('table>tbody>tr>td>strong', text: 'Note', count: 2)
  end
  it 'should display some data' do
    expect(page).to have_css('table>tbody>tr>td', text: 'VND_GET_GEN_FILES_LIST')
    expect(page).to have_css('table>tbody>tr>td', text: 'sp_20181121131154_afs')
    expect(page).to have_css('table>tbody>tr>td', text: '(sp) OCLC WorldCat Collection Sets')
  end
end
