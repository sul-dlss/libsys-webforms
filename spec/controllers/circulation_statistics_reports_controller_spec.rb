require 'rails_helper'
require 'circ_stats_report_examples'
RSpec.describe CirculationStatisticsReportsController, type: :controller do
  before(:each) do
    stub_current_user(FactoryBot.create(:authorized_user))
  end

  let(:valid_attributes) do
    { email: 'test@test.org',
      lib_array: ['GREEN'],
      format_array: ['', 'MARC'],
      call_lo: 'L' }
  end
  let(:invalid_attributes) { valid_attributes.update(lib_array: nil) }

  describe 'get#new' do
    it 'renders the correct template' do
      get 'new'
      expect(response).to render_template('new')
    end
  end
  describe 'get#home_locations' do
    it 'returns a 200 response code' do
      get :home_locations, xhr: true
      expect(response.status).to eq(200)
    end
  end
  describe 'post#create' do
    it 'redirects to root_url on success' do
      post :create, params: { circulation_statistics_report: valid_attributes }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(root_path)
    end
    it 'renders new template on failure' do
      post :create, params: { circulation_statistics_report: invalid_attributes }
      expect(response).to render_template('new')
    end
  end

  include_examples 'circ_stats_report_examples'
end
