require 'rails_helper'

describe 'Accession Number Updates Pages' do
  before do
    stub_current_user(create(:authorized_user))
    @accession_number = create(:accession_number)
    @zvc_number = create(:zvc_number)
    visit accession_number_updates_path
  end

  it 'returns a list of links for resource types' do
    expect(page).to have_css('li>a', text: 'Visual Materials')
  end

  it 'returns a list of links for locations' do
    expect(page).to have_css('li>a', text: 'Media Microtext')
  end

  describe 'accession number generator for visual materials resource type' do
    before do
      click_link 'Visual Materials'
    end

    it 'displays the header' do
      expect(page).to have_css('h3', text: 'Visual Materials')
    end

    it 'displays the table header' do
      expect(page).to have_css('th', text: 'Location')
    end

    it 'diaplays one visual material type option' do
      expect(page).to have_css('tr>td', text: 'DVD')
    end

    it 'displays another visual material type option' do
      expect(page).to have_css('tr>td', text: 'ZVC')
    end

    it 'has a link to generate the accession number' do
      expect(page).to have_css('td>a', text: 'Get number')
    end
  end

  describe 'accession number generator for media microtext resource type' do
    before do
      click_link 'Media Microtext'
    end

    it 'displays the header' do
      expect(page).to have_css('h3', text: 'Media Microtext')
    end

    it 'displays the table header' do
      expect(page).to have_css('th', text: 'Resource Type')
    end

    it 'has a link to generate the accession number' do
      expect(page).to have_css('td>a', text: 'Get number')
    end
  end
end
