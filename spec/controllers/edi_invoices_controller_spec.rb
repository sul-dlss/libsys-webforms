require 'rails_helper'

RSpec.describe EdiInvoicesController, type: :controller do
  describe 'get#index' do
    it 'be succesful returning the index page' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get :index
      expect(response).to be_successful
    end
  end
  describe 'get#invoice_exclude' do
    it 'renders new modal to exclude an invoice' do
      xhr :get, 'invoice_exclude'
      expect(response.headers['Content-Type']).to eq 'text/javascript; charset=utf-8'
    end
  end
end
