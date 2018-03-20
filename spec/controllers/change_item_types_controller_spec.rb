require 'rails_helper'

RSpec.describe ChangeItemTypesController, type: :controller do
  describe 'get#new' do
    it 'renders the correct template' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end
  describe 'post#create' do
    before do
      stub_current_user(FactoryBot.create(:authorized_user))
      allow(ChangeItemType).to receive(:batch_for_transfer_item).and_return(FactoryBot.create(:uni_updates_batch))
    end
    let(:barcode_file) do
      extend ActionDispatch::TestProcess
      fixture_file_upload('files/test_file.txt', 'text/plain')
    end
    it 'returns 302 when changing_item_type' do
      post :create, change_item_type: { current_library: 'GREEN', new_item_type: 'UNKNOWN', item_ids: barcode_file }
      expect(response).to have_http_status(302)
    end
    it 'renders new template with an invalid object' do
      post :create, change_item_type: { current_library: '', new_item_type: '' }
      expect(response).to render_template('new')
    end
  end
end
