
require 'rails_helper'

RSpec.describe ChangeHomeLocationsController, type: :controller do
  describe 'get#new' do
    it 'renders the correct template' do
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
    it 'returns 302 when changing_item_type' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, change_home_location: { current_library: 'GREEN',
                                            new_home_location: 'STACKS',
                                            item_ids: barcode_file }
      expect(response).to have_http_status(302)
    end
    it 'renders new template with an invalid object' do
      stub_current_user(FactoryGirl.create(:authorized_user))
      post :create, change_current_location: { current_library: '',
                                               new_current_location: '' }
      expect(response).to render_template('new')
    end
  end
end
