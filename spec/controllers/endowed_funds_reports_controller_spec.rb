require 'rails_helper'

RSpec.describe EndowedFundsReportsController, type: :controller do
  before do
    stub_current_user(FactoryGirl.create(:authorized_user))
  end

  describe 'get#new' do
    it 'renders the correct template' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'post#create' do
    xit 'redirects to root_url if create is successful' do
      post :create, endowed_funds_report: { fund: ['1000501-1-AACIZ'], fund_begin: nil }
      expect(response).to redirect_to root_path
    end
    it 'renders the new template if create is unsuccessful' do
      post :create, endowed_funds_report: { fund: nil, fund_begin: nil }
      expect(response).to render_template('new')
    end
    xit 'gets a set of catalog keys' do
      post :create, endowed_funds_report: { fund: nil, fund_begin: ['1000501-1-AACIZ'] }
      expect(response).to redirect_to root_path
    end
    xit 'creates the cgi params for a get request to symphony using fund string and fy' do
      post :create, endowed_funds_report: { fund: ['1000501-1-AACIZ', '1000502-1-AACIX'],
                                            fund_begin: nil, report_format: 'n',
                                            email: 'some@one.com', fy_start: 'FY 2015' }
      expect(response).to have_http_status(302)
      expect(:fund).to be_present
      expect(:fy_end).to be_present
    end
    xit 'creates the cgi params for a get request to symphony using fund_begins string and cal' do
      post :create, endowed_funds_report: { fund: nil, fund_begin: '1000501-1-AACIZ-',
                                            report_format: 'n', email: 'some@one.com',
                                            cal_start: '2015' }
      expect(response).to have_http_status(302)
      expect(:fund_begin).to be_present
      expect(:cal_end).to be_present
    end
    xit 'creates the cgi params for a get request to symphony using fund_egins string and pd' do
      post :create, endowed_funds_report: { fund: nil, fund_begin: '1000501-1-AACIZ-',
                                            report_format: 'n', email: 'some@one.com',
                                            pd_start: '22-DEC-99' }
      expect(response).to have_http_status(302)
      expect(:fund_begin).to be_present
      expect(:pd_end).to be_present
    end
  end
end
