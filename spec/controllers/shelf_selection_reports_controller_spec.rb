
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

  describe 'get#load_saved_options' do
    it 'returns a 200 response code' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      xhr :get, :load_saved_options, search_name: 'Green Stacks A-Z, testuser'
      expect(response.status).to eq(200)
    end
  end

  describe 'post#create' do
    it 'redirects to root_url when params are valid' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, shelf_selection_report: { email: 'testuser@test.org', range_type: 'lc',
                                              loc_array: 'ALL', call_lo: 'A',
                                              fmt_array: ['', 'EQUIP'], itype_array: ['', 'ATLAS'] }
      expect(response).to redirect_to root_url
    end
    it 'renders the new action when params are invalid' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, shelf_selection_report: { email: '' }
      expect(response).to render_template('new')
    end
  end
end
