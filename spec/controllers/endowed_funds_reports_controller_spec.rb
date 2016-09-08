require 'rails_helper'

RSpec.describe EndowedFundsReportsController, type: :controller do
  describe 'get#new' do
    it 'renders the correct template' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'post#create' do
    it 'redirects to root_url if create is successful' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, endowed_funds_report: { fund: ['1000501-1-AACIZ'], fund_begin: nil }
      expect(response).to redirect_to root_path
    end
    it 'renders the new template if create is unsuccessful' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, endowed_funds_report: { fund: nil, fund_begin: nil }
      expect(response).to render_template('new')
    end
  end
end
