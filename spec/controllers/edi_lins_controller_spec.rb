require 'rails_helper'

RSpec.describe EdiLinsController, type: :controller do
  Rails.application.load_seed
  describe 'allow a noBib entry form' do
    it 'is successful returning the form' do
      xhr :get, :allow_nobib, format: :js
      expect(response).to render_template(:allow_nobib)
    end
  end
  let(:message) { get :update, vendors: 'AMALIV', invoice_number: '592924', invoice_line_number: '11' }
  describe 'update with actual table updates' do
    before do
      stub_current_user(FactoryBot.create(:authorized_user))
    end
    it 'notifies of noBib change when there is no match between edi_lin and edi_sumrz_bib' do
      controller.instance_variable_set(:@message, message)
      expect(flash).to be_present
      expect(response).to redirect_to edi_invoices_menu_path
    end
  end
end
