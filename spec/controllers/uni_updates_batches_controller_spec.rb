require 'rails_helper'

RSpec.describe UniUpdatesBatchesController, type: :controller do
  describe 'GET#show' do
    before { @uni_updates_batch = FactoryGirl.create(:uni_updates_batch) }
    it 'renders the requested batch' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get :show, id: @uni_updates_batch
      expect(response).to render_template :show
    end
  end

  describe 'DELETE#destroy' do
    before { @uni_updates_batch = FactoryGirl.create(:uni_updates_batch) }
    it 'deletes the contact' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      expect { delete :destroy, id: @uni_updates_batch }.to change(UniUpdatesBatch, :count).by(-1)
    end
    it 'redirects to root_path' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      delete :destroy, id: @uni_updates_batch
      expect(response).to redirect_to root_path
    end
  end
end
