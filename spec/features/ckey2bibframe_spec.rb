require 'rails_helper'

describe 'Do a conversion' do
  xit 'Does a conversion and displays a page with a conversion result' do
    visit new_ckey2bibframe_path

    fill_in 'ckey2bibframe_ckey', with: '123'
    fill_in 'ckey2bibframe_baseuri', with: Settings.base_uri.to_s

    click_button 'Do conversion'

    expect(page).to have_css('h1', text: 'Ckey to Bibframe2 Conversion')
    expect(page).to have_css('h3', text: 'MarcXML')
    expect(page).to have_css('h3', text: 'Bibframe2')
    expect(page).to have_css('pre', text: '<?xml version="1.0" encoding="UTF-8"?>')
    expect(page).to have_css('pre', text: '<marcxml:controlfield tag="001">123</marcxml:controlfield>')
    expect(page).to have_css('pre', text: %(<bf:Work rdf:about="#{Settings.base_uri}123#Work">))
  end
end
