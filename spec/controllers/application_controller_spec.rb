require 'rails_helper'

describe ApplicationController do
  before do
    request.env['REMOTE_USER'] = 'some-user'
  end
  describe '#user_id' do
    it 'should return a user_id when there is a user in the environment' do
      allow(controller.request).to receive(:env).and_return('REMOTE_USER' => 'some-user')
      user = controller.send(:user_id)
      expect(user).to eq('some-user')
    end
  end
end
