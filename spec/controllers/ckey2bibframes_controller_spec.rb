require 'rails_helper'

RSpec.describe Ckey2bibframesController do
  describe 'GET #new' do
    xit 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    # Temporarily disable ckey2bibframe until it is requested as needed
    xit 'returns http success' do
      get :show, params: { ckey: '123', baseuri: 'http://ld4p.stanford.edu' }
      expect(response).to have_http_status(:success)
    end
  end
end
