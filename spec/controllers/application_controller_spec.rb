require 'rails_helper'

describe ApplicationController do
  before do
    request.env['REMOTE_USER'] = 'some-user'
    allow(controller.request).to receive(:env).and_return('REMOTE_USER' => 'some-user')
  end
  describe '#user_id' do
    it 'should return a user_id when there is a user in the environment' do
      user = controller.send(:user_id)
      expect(user).to eq('some-user')
    end
  end
  describe '#current_user' do
    it 'should set the current_user as a webauth_user' do
      user = controller.send(:user_id)
      current_user = controller.send(:current_user)
      expect(current_user).to eq(user)
    end
  end
end
