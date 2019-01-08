require 'rails_helper'

describe 'packages run tests' do
  before(:each) do
    stub_current_user(FactoryBot.create(:admin_user))
    visit run_tests_packages_path
  end

  it 'should display a page heading' do
    expect(page).to have_css('h1', text: 'Run test loads on active packages')
  end
  it 'should display heading to list and transfer files' do
    expect(page).to have_css('h3', text: 'Listing and transferring files')
  end
  it 'should display button to show files to load' do
    expect(page).to have_css('table>tbody>tr>td>a', text: 'Show files to load')
  end
end
