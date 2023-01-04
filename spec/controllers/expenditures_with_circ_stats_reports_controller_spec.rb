require 'rails_helper'

RSpec.describe ExpendituresWithCircStatsReportsController do
  before do
    stub_current_user(create(:authorized_user))
    create(:expenditures_fy_date)
  end

  describe 'get#new' do
    it 'be succesful returning the index page' do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'post#create' do
    let(:params) do
      { email: 'someone@some.one', fund: %w[1008930-1-HAGOY],
        lib_array: %w[GREEN SAL3], format_array: %w[MANUSCRPT MAP MARC] }
    end

    it 'raises an error when fiscal year is not in the table' do
      allow(controller).to receive(:create).and_raise(ActiveRecord::RecordNotFound)
      params = { email: 'someone@some.one', fund_begin: 'All SUL Funds',
                 lib_array: %w[ART], format_array: %w[MARC],
                 date_type: 'fiscal', fy_start: 'FY 2015' }
      post :create, params: { expenditures_with_circ_stats_report: params }

      expect(flash[:error]).to eq('There are no records for the specified date range')
    end

    it 'returns 302 when saving a report for fiscal years' do
      params.merge!(date_type: 'fiscal', fy_start: 'FY 2009')
      post :create, params: { expenditures_with_circ_stats_report: params }
      expect(response).to have_http_status(:found)
    end

    it 'returns 302 when saving a report for calendar years with only cal_start set' do
      params.merge!(date_type: 'calendar', cal_start: '1996')
      post :create, params: { expenditures_with_circ_stats_report: params }
      expect(response).to have_http_status(:found)
    end

    it 'returns 302 when saving a report for calendar years with cal_start and cal_end set' do
      params.merge!(date_type: 'calendar', cal_start: '1996', cal_end: '1997')
      post :create, params: { expenditures_with_circ_stats_report: params }
      expect(response).to have_http_status(:found)
    end

    it 'returns 302 when saving a report for paydate years with only pd_start set' do
      params.merge!(date_type: 'paydate', pd_start: '22-DEC-99')
      post :create, params: { expenditures_with_circ_stats_report: params }
      expect(response).to have_http_status(:found)
    end

    it 'returns 302 when saving a report for paydate years with pd_start and pd_end set' do
      params.merge!(date_type: 'paydate', pd_start: '17-DEC-99', pd_end: '22-DEC-99')
      post :create, params: { expenditures_with_circ_stats_report: params }
      expect(response).to have_http_status(:found)
    end

    it 'renders new template with an invalid object' do
      post :create, params: { expenditures_with_circ_stats_report: { email: '' } }
      expect(response).to render_template('new')
    end
  end
end
