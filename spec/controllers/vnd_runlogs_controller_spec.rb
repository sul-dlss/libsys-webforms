require 'rails_helper'

RSpec.describe VndRunlogsController, type: :controller do
  before do
    stub_current_user(FactoryBot.create(:admin_user))
  end
  describe 'GET #recent' do
    it 'returns http success' do
      get :recent
      expect(response).to have_http_status(:success)
    end
  end
end
