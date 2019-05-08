require 'rails_helper'
RSpec.describe ShelfSelSearchesController, type: :controller do
  describe 'delete_saved_search method' do
    it 'returns a 200 response code' do
      stub_current_user(FactoryBot.create(:authorized_user))
      FactoryBot.create(:shelf_sel_search)
      get :delete_saved_search, params: { user_name: 'mahmed',
                                          search_name: 'Green Stacks E-F' }, xhr: true
      expect(response.status).to eq(200)
    end
  end
end
