require 'rails_helper'

RSpec.describe Sal3BatchRequestsBatchesController, type: :controller do
  describe 'get#index' do
    it 'is successful returning the index page' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'index'
      expect(response).to render_template('index')
    end
  end
  describe 'get#new' do
    it 'be succesful returning the new page' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end
  describe 'post#create' do
    let(:barcode_file) do
      extend ActionDispatch::TestProcess
      fixture_file_upload('files/test_file.txt', 'text/plain')
    end
    it 'returns 302 when saving sal3_batch_requests_batch' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, sal3_batch_requests_batch: { user_sunetid: 'some-id',
                                                 load_date: '16-06-14',
                                                 last_action_date: '16-06-24',
                                                 bc_file: barcode_file }

      expect(response).to have_http_status(302)
    end
    it 'renders new template with an invalid object' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, sal3_batch_requests_batch: { batch_id: '' }
      expect(response).to render_template('new')
    end
  end
end
