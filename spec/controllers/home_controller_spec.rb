require 'rails_helper'

RSpec.describe HomeController do
  describe 'get#home, get#index' do
    it 'redirects to accession numbers' do
      get :index
      expect(response).to redirect_to accession_number_updates_path
    end
  end
end
