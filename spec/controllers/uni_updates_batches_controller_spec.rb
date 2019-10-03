require 'rails_helper'

RSpec.describe UniUpdatesBatchesController, type: :controller do
  describe 'GET#show' do
    before { @uni_updates_batch = FactoryBot.create(:uni_updates_batch) }

    it 'renders the requested batch' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get :show, params: { id: @uni_updates_batch }
      expect(response).to render_template :show
    end
  end

  describe 'DELETE#destroy' do
    before { @uni_updates_batch = FactoryBot.create(:uni_updates_batch) }

    it 'deletes the contact' do
      stub_current_user(FactoryBot.create(:authorized_user))
      expect { delete :destroy, params: { id: @uni_updates_batch } }.to change(UniUpdatesBatch, :count).by(-1)
    end

    it 'redirects to root_path' do
      stub_current_user(FactoryBot.create(:authorized_user))
      delete :destroy, params: { id: @uni_updates_batch }
      expect(response).to redirect_to root_path
    end
  end
end
