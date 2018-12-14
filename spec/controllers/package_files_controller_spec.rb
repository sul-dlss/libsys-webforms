require 'rails_helper'

RSpec.describe PackageFilesController, type: :controller do
  describe 'GET #queue' do
    it 'returns http success' do
      get :queue
      expect(response).to have_http_status(:success)
    end
  end
end
