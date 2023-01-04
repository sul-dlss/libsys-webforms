require 'rails_helper'

RSpec.describe UniUpdatesBatchesController do
  describe 'GET#show' do
    before { @uni_updates_batch = create(:uni_updates_batch) }

    it 'renders the requested batch' do
      stub_current_user(create(:authorized_user))
      get :show, params: { id: @uni_updates_batch }
      expect(response).to render_template :show
    end
  end

  describe 'DELETE#destroy' do
    before do
      stub_current_user(create(:authorized_user))
      @uni_updates_batch = create(:uni_updates_batch)
      create(:uni_updates)
    end

    it 'deletes the contact' do
      expect { delete :destroy, params: { id: @uni_updates_batch } }.to change(UniUpdatesBatch, :count).by(-1)
    end

    it 'removes the associated uni_updates' do
      delete :destroy, params: { id: @uni_updates_batch }
      expect(UniUpdates.count).to eq 0
    end

    it 'redirects to root_path' do
      delete :destroy, params: { id: @uni_updates_batch }
      expect(response).to redirect_to root_path
    end
  end
end
