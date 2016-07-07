require 'rails_helper'

RSpec.describe ShelfSelectionReportsController, type: :controller do
  describe 'get#new' do
    it 'returns the new form' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'get#home_locations' do
    it 'returns a 200 response code' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      xhr :get, :home_locations
      expect(response.status).to eq(200)
    end
  end
end
