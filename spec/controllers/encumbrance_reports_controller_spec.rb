require 'rails_helper'

RSpec.describe EncumbranceReportsController, type: :controller do
  describe 'get#new' do
    it 'be succesful returning the index page' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end
  describe 'post#create' do
    it 'returns 302 when saving encumbrance report' do
      stub_current_user(FactoryBot.create(:authorized_user))
      post :create, params: { encumbrance_report: { email: 'someone@some.one',
                                                    fund: %w[1008930-1-HAGOY],
                                                    fundcyc_cycle: '2016' } }

      expect(response).to have_http_status(302)
    end
    it 'renders new template with an invalid object' do
      stub_current_user(FactoryBot.create(:authorized_user))
      post :create, params: { encumbrance_report: { fund: '' } }
      expect(response).to render_template('new')
    end
  end
end
