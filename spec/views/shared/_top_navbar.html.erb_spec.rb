require 'rails_helper'

describe 'shared/_top_navbar.html.erb' do
  before do
    stub_current_user_for_view {}
    stub_user_id_for_view {}
    stub_webauth_user_for_view {}
    render
  end

  describe 'login link' do
    it 'has a login link if there is no user' do
      expect(rendered).to have_css('a', text: 'Login')
    end
  end
end
