require 'rails_helper'

RSpec.describe EdiInvoicesController, type: :controller do
  before(:context) do
    @edi_invoice = FactoryBot.create(:edi_invoice)
  end
  describe 'get#index' do
    it 'be successful returning the index page' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get :index
      expect(response).to be_successful
      expect(assigns(:edi_invoice)).to be_kind_of(ActiveRecord::Relation)
    end
  end
  describe 'get#invoice_exclude' do
    it 'renders new modal to exclude an invoice' do
      get :invoice_exclude, format: 'js', xhr: true
      expect(response).to have_http_status(302)
    end
  end
  describe 'get#change_invoice_line' do
    it 'renders new modal to change an invoice line' do
      get :change_invoice_line, format: 'js', xhr: true
      expect(response).to have_http_status(302)
    end
  end
end
