require 'rails_helper'

RSpec.describe ExpendituresWithCircStatsReportsController, type: :controller do
  describe 'get#new' do
    it 'be succesful returning the index page' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end
  describe 'post#create' do
    it 'returns 302 when saving a report for fiscal years' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      # a factory for travis:
      FactoryGirl.create(:expenditures_fy_date)
      post :create, expenditures_with_circ_stats_report: { email: 'someone@some.one',
                                                           fund: '1008930-1-HAGOY',
                                                           lib_array: %w(GREEN),
                                                           format_array: %w(MANUSCRPT MAP MARC),
                                                           date_type: 'fiscal',
                                                           fy_start: 'FY 2009' }
      expect(response).to have_http_status(302)
    end
    it 'returns 302 when saving a report for calendar years with only cal_start set' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditures_with_circ_stats_report: { email: 'someone@some.one',
                                                           fund: '1008930-1-HAGOY',
                                                           lib_array: %w(GREEN),
                                                           format_array: %w(MANUSCRPT MAP MARC),
                                                           date_type: 'calendar',
                                                           cal_start: '1996' }
      expect(response).to have_http_status(302)
    end
    it 'returns 302 when saving a report for calendar years with cal_start and cal_end set' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditures_with_circ_stats_report: { email: 'someone@some.one',
                                                           fund: '1008930-1-HAGOY',
                                                           lib_array: %w(GREEN),
                                                           format_array: %w(MANUSCRPT MAP MARC),
                                                           date_type: 'calendar',
                                                           cal_start: '1996',
                                                           cal_end: '1997' }
      expect(response).to have_http_status(302)
    end
    it 'returns 302 when saving a report for paydate years with only pd_start set' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditures_with_circ_stats_report: { email: 'someone@some.one',
                                                           fund: '1008930-1-HAGOY',
                                                           lib_array: %w(GREEN),
                                                           format_array: %w(MANUSCRPT MAP MARC),
                                                           date_type: 'paydate',
                                                           pd_start: '22-DEC-99' }
      expect(response).to have_http_status(302)
    end
    it 'returns 302 when saving a report for paydate years with pd_start and pd_end set' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditures_with_circ_stats_report: { email: 'someone@some.one',
                                                           fund: '1008930-1-HAGOY',
                                                           lib_array: %w(GREEN),
                                                           format_array: %w(MANUSCRPT MAP MARC),
                                                           date_type: 'paydate',
                                                           pd_start: '17-DEC-99',
                                                           pd_end: '22-DEC-99' }
      expect(response).to have_http_status(302)
    end
    it 'renders new template with an invalid object' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, expenditures_with_circ_stats_report: { email: '' }
      expect(response).to render_template('new')
    end
  end
end
