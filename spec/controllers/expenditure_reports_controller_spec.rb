require 'rails_helper'

RSpec.describe ExpenditureReportsController, type: :controller do
  describe 'get#new' do
    it 'be succesful returning the index page' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end
  describe 'post#create' do
    it 'returns 302 when saving expenditure_report for fiscal years' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      # a factory for travis:
      FactoryGirl.create(:expenditures_fy_date)
      post :create, expenditure_report: { email: 'someone@some.one',
                                          fund: ['1008930-1-HAGOY'],
                                          date_type: 'fiscal',
                                          fy_start: 'FY 2009' }
      expect(response).to have_http_status(302)
    end
    it 'returns 302 when saving expenditure_report for calendar years with only cal_start' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditure_report: { email: 'someone@some.one',
                                          fund: ['1008930-1-HAGOY'],
                                          date_type: 'calendar',
                                          cal_start: '1996' }
      expect(response).to have_http_status(302)
    end
    it 'returns 302 when saving expenditure_report for calendar years with cal_start and end' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditure_report: { email: 'someone@some.one',
                                          fund: ['1008930-1-HAGOY'],
                                          date_type: 'calendar',
                                          cal_start: '1996',
                                          cal_end: '1997' }
      expect(response).to have_http_status(302)
    end
    it 'returns 302 when saving expenditure_report for pay date years with only pd_start' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditure_report: { email: 'someone@some.one',
                                          fund: ['1008930-1-HAGOY'],
                                          date_type: 'paydate',
                                          pd_start: '22-DEC-99' }
      expect(response).to have_http_status(302)
    end
    it 'returns 302 when saving expenditure_report for pay date years with pd_start and pd_end' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditure_report: { email: 'someone@some.one',
                                          fund: ['1008930-1-HAGOY'],
                                          date_type: 'paydate',
                                          pd_start: '22-DEC-99',
                                          pd_end: '10-DEC-99' }
      expect(response).to have_http_status(302)
    end
    it 'renders new template with an invalid object' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditure_report: { email: '' }
      expect(response).to render_template('new')
    end
  end
end
