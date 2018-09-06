require 'rails_helper'

RSpec.describe LobbytrackController, type: :controller do
  describe 'get#show', type: :lobbytrack do
    before do
      stub_current_user(FactoryBot.create(:authorized_user))
    end
    it 'returns the array of data if the id exists' do
      get :show, id: '1104840'
      expect(response).to render_template 'show'
    end
    it 'returns to the home page if the id does not exist' do
      get :show, id: '123'
      expect(flash).to be_present
      expect(response).to redirect_to root_path
    end
  end
end
