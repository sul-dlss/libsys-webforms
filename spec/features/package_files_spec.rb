require 'rails_helper'

describe 'Package Files', type: :feature do
  before do
    stub_current_user(create(:admin_user))
    @package_file = create(:package_file)
    @package_file_done = create(:package_file_done)
    @package = create(:package)
  end

  context 'with queue page' do
    before do
      visit package_files_queue_path
    end

    it 'displays a table with Package ID header' do
      expect(page).to have_css('table>thead>tr>th', text: 'Package ID')
    end

    it 'displays a table with File Name header' do
      expect(page).to have_css('table>thead>tr>th', text: 'File Name')
    end

    it 'displays file name' do
      expect(page).to have_css('table>tbody>tr>td', text: 'tv_theatervideo_all_pp_DELETES.mrc')
    end
  end

  context 'when completed page' do
    before do
      stub_current_user(create(:staff_user))
      visit package_files_completed_url(package_id: @package_file_done.package_id)
    end

    it 'returns http success for staff_user' do
      expect(page).to have_http_status(:success)
    end

    it 'displays a table with Package ID header' do
      expect(page).to have_css('table>thead>tr>th', text: 'Package ID')
    end

    it 'displays a table with File Name header' do
      expect(page).to have_css('table>thead>tr>th', text: 'File Name')
    end

    it 'displays a table with Load Status header' do
      expect(page).to have_css('table>thead>tr>th', text: 'Load Status')
    end

    it 'displays file name' do
      expect(page).to have_css('table>tbody>tr>td', text: 'tv_theatervideo_all_pp_NEW.mrc')
    end
  end
end
