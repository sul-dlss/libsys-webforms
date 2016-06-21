require 'rails_helper'

RSpec.describe EncumbranceReportsController, type: :controller do
  describe 'get#new' do
    it 'be succesful returning the index page' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
    describe 'post#create' do
      it 'returns 302 when saving sal3_batch_requests_batch' do
        stub_current_user(FactoryGirl.create(:authorized_user))
        post :create, encumbrance_report: { email: 'someone@some.one',
                                            fund_id: '1008930-1-HAGOY',
                                            fundcyc_cycle: '2016' }

        expect(response).to have_http_status(302)
      end
      it 'renders new template with an invalid object' do
        stub_current_user(FactoryGirl.create(:authorized_user))
        post :create, encumbrance_report: { fund_id: '' }
        expect(response).to redirect_to root_path
      end
    end
  end
end
