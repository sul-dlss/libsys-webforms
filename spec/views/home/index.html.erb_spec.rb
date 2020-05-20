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

    it 'displays the batch record updates link for viewing only' do
      expect(rendered).to have_link('Batch record updates', href: 'batch_record_updates')
    end

    # Temporarily disable ckey2bibframe until it is requested as needed
    xit 'displays ckey2Bibframe link' do
      expect(rendered).to have_link('Ckey to Bibframe Conversion', href: '/ckey2bibframes/new')
    end
  end

  describe 'LobbyTrack reports' do
    context 'when authorized user' do
      before do
        stub_current_user_for_view { FactoryBot.create(:authorized_user) }
        stub_user_id_for_view { FactoryBot.create(:authorized_user) }
        render
      end

      it 'shows the lobbytrack menu item' do
        expect(rendered).to have_link('LobbyTrack Reports')
      end
    end

    context 'when non-authorized user' do
      before do
        stub_current_user_for_view { FactoryBot.create(:blank_user) }
        stub_user_id_for_view { FactoryBot.create(:blank_user) }
        render
      end

      it 'does not show the lobbytrack menu item' do
        expect(rendered).not_to have_link('LobbyTrack Reports')
      end
    end
  end
end
