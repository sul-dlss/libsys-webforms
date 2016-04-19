require 'rails_helper'

describe ApplicationController do
  before do
    request.env['REMOTE_USER'] = 'testuser'
    allow(controller.request).to receive(:env).and_return('REMOTE_USER' => 'testuser')
  end
  describe '#user_id' do
    it 'should return a user_id when there is a user in the environment' do
      user = controller.send(:user_id)
      expect(user).to eq('testuser')
    end
  end
  describe '#current_user' do
    it 'should set the current_user as a webauth_user' do
      user = controller.send(:user_id)
      current_user = FactoryGirl.create(:authorized_user)
      expect(current_user.user_id).to eq(user)
    end
  end
end
