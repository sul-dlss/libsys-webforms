require 'rails_helper'

describe 'package files' do
  before(:each) do
    @package_file = FactoryBot.create(:package_file)
    @package_file_done = FactoryBot.create(:package_file_done)
    @package = FactoryBot.create(:package)
  end

  context 'queue page' do
    before(:each) do
      visit package_files_queue_path
    end
    it 'should display a table' do
      expect(page).to have_css('table>thead>tr>th', text: 'Package ID')
      expect(page).to have_css('table>thead>tr>th', text: 'File Name')
    end
    it 'should display file name' do
      expect(page).to have_css('table>tbody>tr>td', text: 'tv_theatervideo_all_pp_DELETES.mrc')
    end
  end

  context 'completed page' do
    before(:each) do
      visit package_files_completed_url(package_id: @package_file_done.package_id)
    end
    it 'should display a table' do
      expect(page).to have_css('table>thead>tr>th', text: 'Package ID')
      expect(page).to have_css('table>thead>tr>th', text: 'File Name')
      expect(page).to have_css('table>thead>tr>th', text: 'Load Status')
    end
    it 'should display file name' do
      expect(page).to have_css('table>tbody>tr>td', text: 'tv_theatervideo_all_pp_NEW.mrc')
    end
  end
end
