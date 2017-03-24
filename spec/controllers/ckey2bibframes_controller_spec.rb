require 'rails_helper'

RSpec.describe Ckey2bibframesController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, ckey: '123', baseuri: 'http://ld4p.stanford.edu'
      expect(response).to have_http_status(:success)
    end
  end
end
