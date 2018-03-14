require 'rails_helper'

RSpec.describe DigitalBookplatesBatchesController, type: :controller do
  before do
    stub_current_user(FactoryBot.create(:staff_user))
    @add_batch = FactoryBot.create(:digital_bookplates_add_batches)
    @completed_batch = FactoryBot.create(:digital_bookplates_completed_batches)
  end
  let(:ckeys_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('files/test_file.txt', 'text/plain')
  end
  let(:bad_test_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('files/bad_test_file.txt', 'text/plain')
  end
  let(:valid_attributes) do
    { file_obj: ckeys_file,
      druid: 'bb489wp4687',
      user_name: 'Staff User',
      user_email: 'staff_user@example.com',
      batch_type: 'add',
      submit_date: Time.utc(2018, 3, 14, 3, 52, 20) }
  end
  let(:invalid_attributes) { valid_attributes.update(file_obj: bad_test_file) }
  describe 'get#index' do
    it 'is successful returning the index page' do
      get 'index'
      expect(response).to render_template('index')
    end
  end
  describe 'get#queue' do
    it 'is successful returning the queue page' do
      get :queue
      expect(response).to render_template('queue')
    end
  end
  describe 'get#completed' do
    it 'is successful returning the completed page' do
      get :completed
      expect(response).to render_template('completed')
    end
  end
  describe 'post#create' do
    it 'counts the number of ckeys in the uploaded file' do
      post :create, digital_bookplates_batch: valid_attributes
      expect(DigitalBookplatesBatch.last.ckey_count).to eq(2)
    end
    it 'uses PST timezone for submit date to prepend to filename of the uploaded file' do
      post :create, digital_bookplates_batch: valid_attributes
      expect(DigitalBookplatesBatch.last.submit_date.strftime('%Y%m%d%H%M%S')).to eq('20180313205220')
    end
    it 'redirects to queue page on success' do
      post :create, digital_bookplates_batch: valid_attributes
      expect(response).to redirect_to(queue_digital_bookplates_batches_path)
      expect(flash[:notice]).to be_present
    end
    it 'renders "new" template on failure' do
      post :create, digital_bookplates_batch: invalid_attributes
      expect(flash[:error]).to eq 'Too many ckeys in the file! Limit is 10,000 ckeys.'
      expect(response).to render_template('add_batch')
    end
  end
  describe 'delete#destroy' do
    it 'lets users delete a batch' do
      expect { delete :destroy, id: @add_batch }.to change(DigitalBookplatesBatch, :count).by(-1)
    end
    it 'does not delete batches that have a completed_date' do
      expect { delete :destroy, id: @completed_batch }.to change(DigitalBookplatesBatch, :count).by(0)
      expect(flash[:error]).to eq 'Batch cannot be deleted!'
    end
    it 'deletes the uploaded file too' do
      symphony_path = Settings.symphony_dataload_digital_bookplates
      expect(File).not_to exist("#{symphony_path}/#{@add_batch.submit_date}_#{@add_batch.file}")
    end
  end
end
