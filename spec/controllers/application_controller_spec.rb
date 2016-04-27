require 'rails_helper'

describe ApplicationController do
  before do
    request.env['REMOTE_USER'] = 'testuser'
    allow(controller.request).to receive(:env).and_return('REMOTE_USER' => 'testuser')
  end
  describe 'Rescue from CanCan' do
    it 'should flash an error message if access to the resource is denied' do
      user = controller.send(:user_id)
      expect(user).to eq('testuser')
      visit management_reports_path
      expect(response).to be_successful
    end
  end
  describe '#user_id' do
    it 'should return a user_id when there is a user in the environment' do
      user = controller.send(:user_id)
      expect(user).to eq('testuser')
    end
  end
  describe '#current_user' do
    it 'should set the current_user as a webauth_user' do
      user_id = controller.send(:user_id)
      stub_current_user(FactoryGirl.create(:authorized_user))
      current_user = controller.send(:current_user)
      expect(current_user.user_id).to eq(user_id)
    end

    it 'expects AuthorizedUser to receive find_by w/user_id when invoked' do
      pending('learning enough about receiving messages')
      raise 'pending spec...'
    end
  end
end
