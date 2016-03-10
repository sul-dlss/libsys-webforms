require 'rails_helper'

RSpec.describe Sal3BatchRequestsController, type: :controller do
  describe 'get#index' do
    it 'be succesful returning the index page' do
      get :index
      expect(response).to be_successful
    end
  end
end
