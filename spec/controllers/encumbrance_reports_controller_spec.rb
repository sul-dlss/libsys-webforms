require 'rails_helper'

RSpec.describe EncumbranceReportsController do
  describe 'get#new' do
    it 'be succesful returning the index page' do
      stub_current_user(create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'post#create' do
    it 'returns ok when saving encumbrance report' do
      stub_current_user(create(:authorized_user))
      post :create, params: { encumbrance_report: { email: 'someone@some.one', fund: %w[1008930-1-HAGOY],
                                                    fundcyc_cycle: '2016', status: 'REQUEST', output_file: 'enc_rpt123',
                                                    date_request: '2010-01-01 14:22:33' } }

      expect(response).to redirect_to root_path
    end

    it 'renders new template with an invalid object' do
      stub_current_user(create(:authorized_user))
      post :create, params: { encumbrance_report: { email: 'someone@some.one', fund: '' } }
      expect(response).to render_template('new')
    end
  end
end
