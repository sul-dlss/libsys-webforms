require 'rails_helper'

RSpec.describe ConfirmationPagesController, type: :controller do
  describe 'get#confirm_batch_upload' do
    it 'renders the correct template' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'confirm_batch_upload'
      expect(response).to render_template('confirm_batch_upload')
    end
  end
  describe 'get#confirm_batch_deletion' do
    it 'redirects to the root_path' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      get 'confirm_batch_deletion'
      expect(response).to redirect_to root_path
    end
  end
end
