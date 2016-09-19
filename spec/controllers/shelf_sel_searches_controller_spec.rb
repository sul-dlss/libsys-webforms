require 'rails_helper'
RSpec.describe ShelfSelSearchesController, type: :controller do
  describe 'delete_saved_search method' do
    it 'returns a 200 response code' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      FactoryGirl.create(:shelf_sel_search)
      xhr :get, :delete_saved_search, user: 'mahmed', search_name: 'Green Stacks E-F'
      expect(response.status).to eq(200)
    end
  end
end
