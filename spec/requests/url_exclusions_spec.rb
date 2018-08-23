require 'rails_helper'

RSpec.describe 'UrlExclusions', type: :request do
  describe 'GET /url_exclusions' do
    it 'works! (now write some real specs)' do
      get url_exclusions_path
      expect(response).to have_http_status(200)
    end
  end
end
