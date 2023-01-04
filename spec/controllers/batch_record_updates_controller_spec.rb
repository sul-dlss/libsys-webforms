require 'rails_helper'

RSpec.describe BatchRecordUpdatesController do
  describe 'get#index' do
    it 'be succesful returning the index page' do
      stub_current_user(create(:authorized_user))
      get :index
      expect(response).to be_successful
    end
  end

  describe 'get#errors_for_batch' do
    it 'renders the correct template' do
      stub_current_user(create(:authorized_user))
      get 'errors_for_batch'
      expect(response).to render_template('errors_for_batch')
    end
  end

  describe 'get#errors_for_mhld' do
    it 'renders the correct template' do
      stub_current_user(create(:authorized_user))
      get 'errors_for_mhld'
      expect(response).to render_template('errors_for_mhld')
    end
  end

  describe 'get#show_batches_not_complete' do
    it 'renders the correct template' do
      stub_current_user(create(:authorized_user))
      get 'show_batches_not_complete'
      expect(response).to render_template('show_batches_not_complete')
    end
  end

  describe 'get#show_batches_complete' do
    it 'renders the correct template' do
      stub_current_user(create(:authorized_user))
      get 'show_batches_complete'
      expect(response).to render_template('show_batches_complete')
    end
  end
end
