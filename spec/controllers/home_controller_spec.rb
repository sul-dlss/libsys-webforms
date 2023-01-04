require 'rails_helper'

RSpec.describe HomeController do
  describe 'get#home' do
    it 'be succesful returning the home page' do
      get :index
      expect(response).to be_successful
    end
  end
end
