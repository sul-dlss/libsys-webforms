require 'rails_helper'

RSpec.describe EdiInvoicesController, type: :controller do
  before(:each) do
    @edi_invoice = FactoryBot.create(:edi_invoice)
  end
  describe 'get#index' do
    it 'be succesful returning the index page' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get :index
      expect(response).to be_successful
      expect(@edi_invoice).to be_kind_of(EdiInvoice)
    end
  end
  describe 'get#invoice_exclude' do
    it 'renders new modal to exclude an invoice' do
      xhr :get, 'invoice_exclude', format: 'js'
      expect(response).to have_http_status(302)
    end
  end
end
