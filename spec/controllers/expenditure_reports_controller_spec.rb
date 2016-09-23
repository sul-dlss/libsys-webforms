require 'rails_helper'

RSpec.describe ExpenditureReportsController, type: :controller do
  describe 'get#new' do
    it 'be succesful returning the index page' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
    describe 'post#create' do
      it 'returns 302 when saving expenditure_report' do
        stub_current_user(FactoryGirl.create(:authorized_user))
        post :create, expenditure_report: { email: 'someone@some.one',
                                            fund: ['1008930-1-HAGOY'],
                                            date_type: 'fiscal' }
        expect(response).to have_http_status(302)
      end
      it 'renders new template with an invalid object' do
        stub_current_user(FactoryGirl.create(:authorized_user))
        post :create, expenditure_report: { email: '' }
        expect(response).to render_template('new')
      end
    end
  end
end
