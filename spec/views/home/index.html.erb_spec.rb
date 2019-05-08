require 'rails_helper'

describe 'home/index', type: :view do
  describe 'authorized user' do
    before do
      stub_current_user_for_view { FactoryBot.create(:authorized_user) }
      stub_user_id_for_view { FactoryBot.create(:authorized_user) }
      render
    end

    it 'has title' do
      expect(rendered).to have_css('h1', text: 'SUL Staff Web Forms')
    end
    it 'has links section' do
      expect(rendered).to have_css('h3', text: 'What would you like to do?')
    end
  end

  describe 'non-authorized user' do
    before do
      stub_current_user_for_view {}
      stub_user_id_for_view {}
      render
    end

    it 'does not display what would you like to do text' do
      expect(rendered).not_to have_css('h3', text: 'What would you like to do?')
    end
    it 'does not display permissions warning text' do
      expect(rendered).to have_css('div', text: 'You do not have permissions to use other staff web forms.')
    end
    it 'does not display ckey2Bibframe link' do
      expect(rendered).to have_link('Ckey to Bibframe Conversion', href: '/ckey2bibframes/new')
    end
  end
end
