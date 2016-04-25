require 'rails_helper'

RSpec.describe BatchRecordUpdatesController, type: :controller do
  describe 'get#index' do
    it 'be succesful returning the index page' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get :index
      expect(response).to be_successful
    end
  end
end
