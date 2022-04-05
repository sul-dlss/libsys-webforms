require 'rails_helper'

RSpec.describe ManagementReportsController, type: :controller do
  describe 'get#index' do
    it 'be succesful returning the index page' do
      stub_current_user(create(:authorized_user))
      get :index
      expect(response).to be_successful
    end
  end
end
