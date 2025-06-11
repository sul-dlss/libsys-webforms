require 'rails_helper'

describe ApplicationHelper do
  describe 'accession_menu_button' do
    let(:button) { Capybara.string(accession_menu_button) }

    it 'renders the button with main-menu-button id' do
      expect(button).to have_css('button[id="accession-num-menu"]')
    end

    it 'renders the button with a link to the root path' do
      expect(button).to have_css('a[href="/accession_number_updates"]')
    end
  end
end
