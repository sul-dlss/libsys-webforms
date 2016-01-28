require 'rails_helper'

describe HomeController, type: :controller do
  describe '#index' do
    it 'should be successful' do
      get :index
      expect(response).to be_successful
    end
  end
end
