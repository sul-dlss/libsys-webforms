require 'rails_helper'

describe AuthenticationController do
  describe 'login' do
    it 'should redirect back to the provided referrer' do
      request.env['HTTP_REFERER'] = 'https://example.com'
      get :login
      expect(response).to redirect_to('https://example.com')
    end
    it 'should redirect to root_path when there is no provided referrer' do
      get :login
      expect(response).to redirect_to(root_path)
    end
    it 'should have a flash success message informing the user they logged in' do
      get :login
      expect(flash[:success]).to eq 'You have been successfully logged in.'
    end
  end
end
