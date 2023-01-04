require 'rails_helper'
RSpec.describe ShelfSelSearchesController do
  describe 'delete_saved_search method' do
    it 'returns a 200 response code' do
      stub_current_user(create(:authorized_user))
      create(:shelf_sel_search)
      get :delete_saved_search, params: { user_name: 'mahmed',
                                          search_name: 'Green Stacks E-F' }, xhr: true
      expect(response).to have_http_status(:ok)
    end
  end
end
