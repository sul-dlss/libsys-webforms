require 'rails_helper'

RSpec.describe UserloadRerunsController, type: :controller do
  before do
    stub_current_user(create(:authorized_user))
  end

  describe 'GET #new' do
    it 'renders the correct template' do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'redirects to the home page' do
        post :create, params: { userload_rerun: { rerun_date: '2017-01-04' } }
        expect(response).to have_http_status(:found)
      end
    end

    context 'with invalid params' do
      it 'creates a new UserloadRerun' do
        post :create, params: { userload_rerun: { rerun_date: '' } }
        expect(response).to render_template('new')
      end
    end
  end
end
