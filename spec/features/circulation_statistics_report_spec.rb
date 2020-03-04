require 'rails_helper'

describe 'Circulation Statistics Report Page', type: :feature, js: true do
  before do
    FactoryBot.create(:uni_libs_locs)
    stub_current_user(FactoryBot.create(:authorized_user))
    visit new_circulation_statistics_report_path
    select('SAL3', from: 'circulation_statistics_report_lib_array')
  end

  it 'shows the optional criteria when you click on the Proceed to next step button' do
    find_link('Proceed to next step').click
    expect(page).to have_css '#SAL3select option', count: 2
  end
end
