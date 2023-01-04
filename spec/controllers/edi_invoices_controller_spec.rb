require 'rails_helper'

RSpec.describe EdiInvoicesController do
  before do
    stub_current_user(create(:authorized_user))
    @edi_invoice = create(:edi_invoice)
  end

  describe 'get#index' do
    it 'successful returning the index page' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'get#invoice_exclude' do
    it 'renders new modal to exclude an invoice' do
      get :invoice_exclude, format: 'js', xhr: true
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'get#change_invoice_line' do
    it 'renders new modal to change an invoice line' do
      get :change_invoice_line, format: 'js', xhr: true
      expect(response).to have_http_status(:ok)
    end
  end
end
