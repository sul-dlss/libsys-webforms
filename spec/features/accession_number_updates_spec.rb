require 'rails_helper'

describe 'accession number updates pages' do
  before(:each) do
    stub_current_user(FactoryBot.create(:authorized_user))
    @accession_number = FactoryBot.create(:accession_number)
    @zvc_number = FactoryBot.create(:zvc_number)
    visit accession_number_updates_path
  end

  it 'returns a list of links for resource types' do
    expect(page).to have_css('li>a', text: 'Visual Materials')
  end

  it 'returns a list of links for locations' do
    expect(page).to have_css('li>a', text: 'Media Microtext')
  end

  it 'displays a list of accession numbers by resource type' do
    click_link 'Visual Materials'
    expect(page).to have_css('h3', text: 'Visual Materials')
    expect(page).to have_css('th', text: 'Location')
    expect(page).to have_css('tr>td', text: 'DVD')
    expect(page).to have_css('tr>td', text: 'ZVC')
    expect(page).to have_css('td>a', text: 'Get number')
  end

  it 'displays a list of accession numbers by location' do
    click_link 'Media Microtext'
    expect(page).to have_css('h3', text: 'Media Microtext')
    expect(page).to have_css('th', text: 'Resource Type')
    expect(page).to have_css('td>a', text: 'Get number')
  end
end
