require 'rails_helper'

RSpec.describe ExpendituresWithCircStatsReportsController, type: :controller do
  describe 'get#new' do
    it 'be succesful returning the index page' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
    describe 'post#create' do
      it 'returns 302 when saving sal3_batch_requests_batch' do
        stub_current_user(FactoryGirl.create(:authorized_user))
        post :create, expenditures_with_circ_stats_report: { email: 'someone@some.one',
                                                             fund: '1008930-1-HAGOY',
                                                             lib_array: %w(GREEN),
                                                             fmt_array: %w(MANUSCRPT MAP MARC) }
        expect(response).to have_http_status(302)
      end
      it 'renders new template with an invalid object' do
        stub_current_user(FactoryGirl.create(:authorized_user))
        post :create, expenditures_with_circ_stats_report: { email: '' }
        expect(response).to redirect_to root_path
      end
    end
  end
end
