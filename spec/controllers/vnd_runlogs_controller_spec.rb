require 'rails_helper'

RSpec.describe VndRunlogsController do
  before do
    stub_current_user(create(:admin_user))
  end

  describe 'GET #recent' do
    it 'returns http success' do
      get :recent
      expect(response).to have_http_status(:success)
    end
  end
end
