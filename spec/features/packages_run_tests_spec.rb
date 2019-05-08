require 'rails_helper'

describe 'Packages Run Tests', type: :feature do
  before do
    stub_current_user(FactoryBot.create(:admin_user))
    visit run_tests_packages_path
  end

  it 'displays a page heading' do
    expect(page).to have_css('h1', text: 'Run test loads on active packages')
  end
  it 'displays heading to list and transfer files' do
    expect(page).to have_css('h3', text: 'Listing and transferring files')
  end
  it 'displays button to show files to load' do
    expect(page).to have_css('table>tbody>tr>td>a', text: 'Show files to load')
  end
end
