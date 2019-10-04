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
      @sal3_batch_requests_batch = Sal3BatchRequestsBatch.create!(bc_file: barcode_file,
                                                                  batch_pullmon: 1,
                                                                  pseudo_id: 'MAPSCANLAB',
                                                                  batch_startdate: '11-APR-18',
                                                                  batch_needbydate: '11-APR-18')
      get 'show', params: { id: @sal3_batch_requests_batch }
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
    let(:batch_params) do
      { user_sunetid: 'some-id',
        pseudo_id: 'MAPSCANLAB',
        load_date: '16-06-14',
        batch_startdate: '16-06-18',
        batch_needbydate: '16-06-30',
        batch_pullmon: 1,
        last_action_date: nil,
        bc_file: barcode_file }
    end

    it 'returns 302 when saving sal3_batch_requests_batch' do
      stub_current_user(FactoryBot.create(:authorized_user))
      post :create, params: { sal3_batch_requests_batch: batch_params }

      expect(response).to have_http_status(:found)
    end

    it 'renders new template with an invalid object' do
      stub_current_user(FactoryBot.create(:authorized_user))
      post :create, params: { sal3_batch_requests_batch: { batch_id: '' } }
      expect(response).to render_template('new')
    end
  end

  describe 'get#edit' do
    it 'is successful returning the edit view' do
      @sal3_batch_requests_batch = Sal3BatchRequestsBatch.create!(bc_file: barcode_file,
                                                                  batch_pullmon: 1,
                                                                  pseudo_id: 'MAPSCANLAB',
                                                                  batch_startdate: '11-APR-18',
                                                                  batch_needbydate: '11-APR-18')
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'edit', params: { id: @sal3_batch_requests_batch }
      expect(response).to be_successful
    end
  end

  describe 'put#update' do
    before do
      @sal3_batch_requests_batch = Sal3BatchRequestsBatch.create!(bc_file: barcode_file,
                                                                  pseudo_id: 'MAPSCANLAB',
                                                                  priority: 2,
                                                                  batch_numpullperday: 10,
                                                                  batch_pullmon: 1,
                                                                  batch_startdate: '11-APR-18',
                                                                  batch_needbydate: '11-APR-18')
    end

    it 'updates the requested batch' do
      stub_current_user(FactoryBot.create(:authorized_user))
      put :update, params: { id: @sal3_batch_requests_batch, sal3_batch_requests_batch: { priority: 1 } }
      @sal3_batch_requests_batch.reload
      expect(@sal3_batch_requests_batch.priority).to eq(1)
    end

    it 'is unsuccessful returning to the edit view without required dates' do
      stub_current_user(FactoryBot.create(:authorized_user))
      put :update, params: { id: @sal3_batch_requests_batch, sal3_batch_requests_batch: { batch_startdate: nil,
                                                                                          batch_needbydate: nil } }
      @sal3_batch_requests_batch.reload
      expect(response).to render_template('edit')
    end

    it 'redirects to the edit page when update fails' do
      # this spec passes, but doesn't seem to get coverage
      # sal3_batch_requests_batches_controller.rb: 1 untested lines: [40]
      # which is: render 'edit'
      stub_current_user(FactoryBot.create(:authorized_user))
      put :update, params: { id: @sal3_batch_requests_batch, sal3_batch_requests_batch: { priority: 'foo' } }
      expect(response).not_to be_successful
    end
  end
end
