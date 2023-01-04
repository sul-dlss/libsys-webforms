require 'rails_helper'

RSpec.describe PlSqlJobController do
  describe 'GET#create' do
    it 'gets the corrrect pl_sql_job params' do
      get :create, params: { command: 'test_command', confirm: 'Test' }
      expect(response).to have_http_status(:found)
    end
  end
end
