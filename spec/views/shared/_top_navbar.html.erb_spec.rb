require 'rails_helper'

describe 'shared/_top_navbar.html.erb' do
  before do
    stub_current_user_for_view {}
    stub_user_id_for_view {}
    stub_webauth_user_for_view {}
    render
  end
  describe 'login link' do
    it 'should have a login link if there is no user' do
      expect(rendered).to have_css('a', text: 'Login')
    end
  end
  describe 'logout link' do
    before do
      stub_current_user_for_view { FactoryGirl.create(:authorized_user) }
      stub_user_id_for_view { FactoryGirl.create(:authorized_user).user_id }
      stub_webauth_user_for_view { FactoryGirl.create(:authorized_user) }
      render
    end
    it 'should have a logout link if there is a user' do
      expect(rendered).to have_css('a', text: 'testuser: Logout')
    end
    it 'should redirect users back to the home page of the app' do
      expect(rendered).to have_link('testuser: Logout', href: '/webauth/logout?referrer=%2F')
    end
  end
end
