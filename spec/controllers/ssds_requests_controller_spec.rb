require 'rails_helper'

RSpec.describe SsdsRequestsController, type: :controller do
  let(:ssds_request_params) do
    {
      unicorn_id_in: '510163',
      name: 'Jean Grey',
      phone: '650-123-4567',
      sunet: 'sunet_id',
      dataset_type: 'TAPE',
      department: 'Sociology',
      affiliation: 'Staff',
      sponsor: 'Professor X',
      call_no_in: 'TAPE NO. AS1999 ETC',
      notes: 'note'
    }
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new, params: ssds_request_params
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index, params: { ssds_request: ssds_request_params }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:ssds) { SsdsRequest.new(ssds_request_params) }
    let(:mailer) { WebformsMailer.ssds_request(ssds) }

    before do
      post :create, params: { ssds_request: ssds_request_params }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index action' do
      expect(controller).to render_template 'index'
    end

    it 'sends mail' do
      expect(mailer).to be_a_kind_of(ActionMailer::MessageDelivery)
    end
  end
end
