require 'rails_helper'

describe 'New SSDS Request', type: :feature do
  before do
    stub_current_user(create(:blank_user))
    ENV['REMOTE_USER'] = 'blank_user'
    visit 'ssds_requests/new?call_no_in=TAPE+NO.+AS1999+ETC&title_in=Shool+for+Gifted+Youngsters&unicorn_id_in=510163'
  end

  it 'has a contect link for SSRC' do
    expect(page).to have_css('a[href="mailto:consult-data@lists.stanford.edu"]')
  end

  it 'shows the SUNet ID label' do
    expect(page).to have_css('label[for="ssds_request_sunet"]')
  end

  it 'shows the SUNet ID field do' do
    expect(page).to have_css('input#ssds_request_sunet')
  end

  it 'shows the SUNet ID field with passed in value' do
    expect(page).to have_css('input#ssds_request_sunet[value="blank_user"]')
  end

  it 'shows the Stanford Affiliation label' do
    expect(page).to have_css('label[for="ssds_request_affiliation"]')
  end

  it 'shows the Stanford Affiliation options' do
    expect(page).to have_css('select#ssds_request_affiliation > option[value="Other"]')
  end

  it 'shows the Name label' do
    expect(page).to have_css('label[for="ssds_request_name"]')
  end

  it 'shows the Name with passed in values' do
    expect(page).to have_css('input#ssds_request_name[value="Blank User"]')
  end

  it 'shows the Department label' do
    expect(page).to have_css('label[for="ssds_request_department"]')
  end

  it 'shows the Department options' do
    expect(page).to have_css('select#ssds_request_department > option[value="Other"]')
  end

  it 'shows the Phone label' do
    expect(page).to have_css('label[for="ssds_request_phone"]')
  end

  it 'shows the Phone field' do
    expect(page).to have_css('input#ssds_request_phone')
  end

  it 'shows the Sponsor label' do
    expect(page).to have_css('label[for="ssds_request_sponsor"]')
  end

  it 'shows the Sponsor field' do
    expect(page).to have_css('input#ssds_request_sponsor')
  end

  it 'shows the Dataset Type label' do
    expect(page).to have_css('label[for="ssds_request_dataset_type"]')
  end

  it 'shows the Dataset Type options with TAPE selected' do
    expect(page).to have_css('select#ssds_request_dataset_type > option[value="TAPE"][selected="selected"]')
  end

  it 'shows the Dataset Number label' do
    expect(page).to have_css('label[for="ssds_request_call_no_in"]')
  end

  it 'shows the Dataset Number with passed in value' do
    expect(page).to have_css('input#ssds_request_call_no_in[value="TAPE NO. AS1999 ETC"]')
  end

  it 'shows the Catalog Key label' do
    expect(page).to have_css('label[for="ssds_request_unicorn_id_in"]')
  end

  it 'shows the Catalog Key with passed in value' do
    expect(page).to have_css('input#ssds_request_unicorn_id_in[value="510163"]')
  end

  it 'shows the Note label' do
    expect(page).to have_css('label[for="ssds_request_notes"]')
  end

  it 'shows the Notes field' do
    expect(page).to have_css('textarea#ssds_request_notes')
  end

  it 'has a submit button' do
    expect(page).to have_css('input[type="submit"]')
  end
end
