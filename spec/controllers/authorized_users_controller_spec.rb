require 'rails_helper'

RSpec.describe AuthorizedUsersController, type: :controller do
  before do
    stub_current_user(FactoryBot.create(:authorized_user))
    @authorized_user = FactoryBot.create(:admin_user)
    @staff_user = FactoryBot.create(:staff_user)
    @blank_user = FactoryBot.create(:blank_user)
  end

  describe 'get#index' do
    it 'be succesful returning the index page' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'get#new' do
    it 'renders new modal to add a user' do
      get :new, xhr: true
      expect(response.headers['Content-Type']).to eq 'text/javascript; charset=utf-8'
    end
  end

  describe 'post#create' do
    it 'returns 302 when creating a new user' do
      post :create, params: { authorized_user: { user_id: 'create_user', user_name: 'New User',
                                                 mgt_rpts: '1' } }
      expect(response).to have_http_status(:found)
    end
    it 'flashes error if user missing user_id or user_name' do
      post :create, params: { authorized_user: { user_id: '', user_name: ' ', mgt_rpts: '1' } }
      expect(flash[:error]).to be_present
    end
    it 'flashes error if user already exists' do
      post :create, params: { authorized_user: { user_id: 'admin_user', user_name: ' ', mgt_rpts: '1' } }
      expect(flash[:error]).to eq 'User already exists!'
    end
  end

  describe 'get#edit' do
    it 'renders the correct template' do
      get 'edit', params: { user_id: @authorized_user }
      expect(response).to render_template('edit')
    end
  end

  describe 'patch#update' do
    it 'does not update the user id' do
      patch :update, params: { user_id: 'admin_user', authorized_user: { user_id: 'adminuser' } }
      @authorized_user.reload
      expect(@authorized_user.user_id).to eq('admin_user')
    end
    it 'updates an checked checkbox to Y' do
      patch :update, params: { user_id: 'admin_user', authorized_user: { unicorn_circ_batch: 'Y' } }
      @authorized_user.reload
      expect(@authorized_user.unicorn_circ_batch).to eq('Y')
    end
    it 'updates an unchecked checkbox to nil' do
      patch :update, params: { user_id: 'admin_user', authorized_user: { ora_admin: '' } }
      @authorized_user.reload
      expect(@authorized_user.ora_admin).to eq('')
    end

    context 'when the user name is blank' do
      before do
        patch :update, params: { user_id: 'admin_user', authorized_user: { user_name: '' } }
        @authorized_user.reload
      end

      it 'does not update the user name' do
        expect(@authorized_user.user_name).to eq('Admin User')
      end
      it 'flashes a message' do
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'delete#delete' do
    it 'deletes a user' do
      expect { delete :delete, params: { user_id: @blank_user } }.to change(AuthorizedUser, :count).by(-1)
    end
    it 'does not delete an admin user' do
      expect { delete :delete, params: { user_id: @authorized_user } }.to change(AuthorizedUser, :count).by(0)
    end
    it 'does not delete a staff user that still has access to an app' do
      expect { delete :delete, params: { user_id: @staff_user } }.to change(AuthorizedUser, :count).by(0)
    end
  end
end
