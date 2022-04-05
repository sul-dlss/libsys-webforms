require 'rails_helper'

describe ApplicationController do
  before do
    request.env['REMOTE_USER'] = 'testuser'
    allow(controller.request).to receive(:env).and_return('REMOTE_USER' => 'testuser')
  end

  describe 'Rescue from CanCan' do
    it 'allows access to the resource if the user is allowed' do
      controller.send(:user_id)
      visit management_reports_path
      expect(response).to be_successful
    end
  end

  describe '#user_id' do
    it 'returns a user_id when there is a user in the environment' do
      user = controller.send(:user_id)
      expect(user).to eq('testuser')
    end
  end

  describe '#current_user' do
    it 'sets the current_user as a webauth_user' do
      user_id = controller.send(:user_id)
      stub_current_user(create(:authorized_user))
      current_user = controller.send(:current_user)
      expect(current_user.user_id).to eq(user_id)
    end
  end

  describe '#webauth_user' do
    before do
      request.env['REMOTE_USER'] = ''
      allow(controller.request).to receive(:env).and_return('REMOTE_USER' => '')
    end

    it 'checks whether the user is both an current_user and has a user_id from webauth' do
      stub_current_user(create(:authorized_user))
      webauth_user = controller.send(:webauth_user?)
      expect(webauth_user).to be_falsey
    end
  end
end
