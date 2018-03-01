require 'rails_helper'

RSpec.describe Sal3BatchRequestsBatchesController, type: :controller do
  let(:barcode_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('files/test_file.txt', 'text/plain')
  end
  describe 'get#index' do
    it 'is successful returning the index page' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'index'
      expect(response).to render_template('index')
    end
  end
  describe 'get#show' do
    it 'is successful returning a show page' do
      stub_current_user(FactoryBot.create(:authorized_user))
      @sal3_batch_requests_batch = Sal3BatchRequestsBatch.create!(bc_file_obj: barcode_file)
      get 'show', id: @sal3_batch_requests_batch
      expect(response).to render_template('show')
    end
  end
  describe 'get#new' do
    it 'be succesful returning the new page' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end
  describe 'post#create' do
    it 'returns 302 when saving sal3_batch_requests_batch' do
      stub_current_user(FactoryBot.create(:authorized_user))
      post :create, sal3_batch_requests_batch: { user_sunetid: 'some-id',
                                                 load_date: '16-06-14',
                                                 last_action_date: nil,
                                                 bc_file_obj: barcode_file }

      expect(response).to have_http_status(302)
    end
    it 'renders new template with an invalid object' do
      stub_current_user(FactoryBot.create(:authorized_user))
      post :create, sal3_batch_requests_batch: { batch_id: '' }
      expect(response).to render_template('new')
    end
  end
  describe 'get#edit' do
    it 'is successful returning the edit view' do
      @sal3_batch_requests_batch = Sal3BatchRequestsBatch.create!(bc_file_obj: barcode_file)
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'edit', id: @sal3_batch_requests_batch
      expect(response).to be_success
    end
  end
  describe 'put#update' do
    it 'updates the requested batch' do
      @sal3_batch_requests_batch = Sal3BatchRequestsBatch.create!(bc_file_obj: barcode_file,
                                                                  priority: 2,
                                                                  batch_numpullperday: 10)
      stub_current_user(FactoryBot.create(:authorized_user))
      put :update, id: @sal3_batch_requests_batch, sal3_batch_requests_batch: { priority: 1 }
      @sal3_batch_requests_batch.reload
      expect(@sal3_batch_requests_batch.priority).to eq(1)
    end
    it 'redirects to the edit page when update fails' do
      # this spec passes, but doesn't seem to get coverage
      # sal3_batch_requests_batches_controller.rb: 1 untested lines: [40]
      # which is: render 'edit'
      @sal3_batch_requests_batch = Sal3BatchRequestsBatch.create!(bc_file_obj: barcode_file,
                                                                  priority: 2,
                                                                  batch_numpullperday: 10)
      stub_current_user(FactoryBot.create(:authorized_user))
      put :update, id: @sal3_batch_requests_batch, sal3_batch_requests_batch: { priority: 'foo' }
      expect(response).to_not be_success
    end
  end
end
