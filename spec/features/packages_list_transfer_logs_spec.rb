require 'rails_helper'

describe 'Packages List Transfer Logs' do
  before do
    stub_current_user(create(:admin_user))
    create(:vnd_runlog)
    create(:vnd_runlog_info)
    visit list_transfer_logs_packages_path
  end

  it 'displays a page heading' do
    expect(page).to have_css('h1', text: 'List and transfer logs for active packages')
  end

  it 'displays two log entries for Run date/time' do
    expect(page).to have_css('table td.col-sm-2', text: 'Run date/time', count: 2)
  end

  it 'displays two log entries for Procedure name' do
    expect(page).to have_css('table td.col-sm-2', text: 'Procedure name', count: 2)
  end

  it 'displays two log entries for Message' do
    expect(page).to have_css('table td.col-sm-2', text: 'Message', count: 2)
  end

  it 'displays two log entries for Vendor name' do
    expect(page).to have_css('table td.col-sm-2', text: 'Vendor name', count: 2)
  end

  it 'displays two log entries for Action type' do
    expect(page).to have_css('table td.col-sm-2', text: 'Action type', count: 2)
  end

  it 'displays two log entries for File name' do
    expect(page).to have_css('table td.col-sm-2', text: 'File name', count: 2)
  end

  it 'displays two log entries for Note' do
    expect(page).to have_css('table td.col-sm-2', text: 'Note', count: 2)
  end

  xit 'displays some data, ex 1' do
    expect(page).to have_css('table td.col-sm-10', text: 'VND_GET_GEN_FILES_LIST')
  end

  it 'displays some data, ex 2' do
    expect(page).to have_css('table td.col-sm-10', text: 'sp_20181121131154_afs')
  end

  it 'displays some data, ex 3' do
    expect(page).to have_css('table td.col-sm-10', text: '(sp) OCLC WorldCat Collection Sets')
  end
end
