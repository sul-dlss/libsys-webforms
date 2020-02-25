require 'rails_helper'

RSpec.describe ShelfSelectionReportsController, type: :controller do
  before do
    stub_current_user(FactoryBot.create(:authorized_user))
  end

  describe 'get#new' do
    it 'returns the new form' do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'get#home_locations' do
    it 'returns a 200 response code' do
      get :home_locations, xhr: true
      expect(response.status).to eq(200)
    end
  end

  describe 'get#load_saved_options' do
    it 'returns a 200 response code' do
      get :load_saved_options, params: { search_name: 'Green Stacks A-Z, testuser' }, xhr: true
      expect(response.status).to eq(200)
    end
  end

  describe 'post#create' do
    it 'redirects to root_url when params are valid' do
      post :create, params: { shelf_selection_report: { email: 'testuser@test.org', range_type: 'lc',
                                                        loc_array: 'ALL', call_lo: 'A',
                                                        format_array: ['', 'EQUIP'], itype_array: ['', 'ATLAS'] } }
      expect(response).to redirect_to root_url
    end

    it 'renders the new action when params are invalid' do
      post :create, params: { shelf_selection_report: { email: '' } }
      expect(response).to render_template('new')
    end
  end
end
