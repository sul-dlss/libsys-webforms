require 'rails_helper'

RSpec.describe UserloadRerunsController, type: :controller do
  describe 'GET #new' do
    it 'renders the correct template' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    xit context 'with valid params' do
      it 'redirects to the home page' do
        post :create, params: { rerun_date: '2017-01-04' }
        expect(response).to have_http_status(302)
      end
    end
    xit context 'with invalid params' do
      it 'creates a new UserloadRerun' do
        post :create, params: { rerun_date: '' }
        expect(response).to render_template('new')
      end
    end
  end
end
