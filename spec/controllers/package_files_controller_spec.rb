require 'rails_helper'

RSpec.describe PackageFilesController do
  before do
    stub_current_user(create(:admin_user))
  end

  describe 'GET #queue' do
    it 'returns http success' do
      get :queue
      expect(response).to have_http_status(:success)
    end
  end
end
