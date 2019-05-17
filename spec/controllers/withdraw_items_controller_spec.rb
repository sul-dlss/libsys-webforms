require 'rails_helper'

RSpec.describe WithdrawItemsController, type: :controller do
  describe 'get#new' do
    it 'renders the correct template' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end
  describe 'post#create' do
    let(:barcode_file) do
      extend ActionDispatch::TestProcess
      fixture_file_upload('files/test_file.txt', 'text/plain')
    end
    it 'returns 302 when withdraw_item' do
      stub_current_user(FactoryBot.create(:authorized_user))
      post :create, params: { withdraw_item: { current_library: 'GREEN', item_ids: barcode_file } }
      expect(response).to have_http_status(302)
    end
    it 'renders new template with an invalid object' do
      stub_current_user(FactoryBot.create(:authorized_user))
      post :create, params: { withdraw_item: { current_library: '' } }
      expect(response).to render_template('new')
    end
  end
end
