require 'rails_helper'

describe ApplicationController do
  it 'should return a user when there is a user in the environment' do
    allow(controller).to receive_messages(user_id: 'some-user')
    user = controller.send(:current_user)
    expect(user).to eq 'some-user'
  end
  it 'should return a user from the REMOTE_USER environment variable' do
    allow(controller.request).to receive(:env).and_return('REMOTE_USER' => 'some-remote-user')
    user = controller.send(:current_user)
    expect(user).to eq 'some-remote-user'
  end
end
