require 'rails_helper'

RSpec.describe 'Packages' do
  before do
    stub_current_user(create(:staff_user))
  end

  describe 'GET /packages' do
    it 'works! (now write some real specs)' do
      get packages_path
      expect(response).to have_http_status(:ok)
    end
  end
end
