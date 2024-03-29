require 'rails_helper'

RSpec.describe ChangeItemTypesController do
  describe 'get#new' do
    it 'renders the correct template' do
      stub_current_user(create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'post#create' do
    let(:barcode_file) do
      extend ActionDispatch::TestProcess
      fixture_file_upload('files/test_file.txt', 'text/plain')
    end

    it 'returns 302 when changing_item_type' do
      stub_current_user(create(:authorized_user))
      post :create, params: { change_item_type: { current_library: 'GREEN',
                                                  new_item_type: 'UNKNOWN',
                                                  item_ids: barcode_file } }
      expect(response).to have_http_status(:found)
    end

    it 'renders new template with an invalid object' do
      stub_current_user(create(:authorized_user))
      post :create, params: { change_item_type: { current_library: '', new_item_type: '' } }
      expect(response).to render_template('new')
    end
  end
end
