require 'rails_helper'

RSpec.describe 'packages/index', type: :view do
  before do
    @package = create(:package)
    assign(:packages, [@package])
  end

  context 'when eloader package management admin user' do
    before do
      stub_current_user_for_view { create(:admin_user) }
      render
    end

    it 'displays deactivate package link' do
      assert_select 'a', text: 'Deactivate'.to_s, action: 'deactivate'.to_s
    end

    it 'displays a details package link' do
      assert_select 'a', text: 'Details'.to_s, href: '/packages/1'.to_s
    end

    it 'displays an edit package link' do
      assert_select 'a', text: 'Edit'.to_s, href: '/packages/1/edit'.to_s
    end

    it 'displays a link to show package files loaded' do
      assert_select 'a', text: 'Show pkg files'.to_s, href: '/package_files/completed?package_id=tv'.to_s
    end

    it 'displays a link to add a package' do
      assert_select 'a', text: 'Add package'.to_s, href: '/packages/new'.to_s
    end

    it 'displays a link to run test loads' do
      assert_select 'a', text: 'Run tests'.to_s, href: '/packages/run_tests'.to_s
    end

    it 'does not display copy package settings form in test environment' do
      expect(rendered).not_to have_link('a', text: 'Copy package settings from test')
    end
  end

  context 'when eloader package management staff user' do
    before do
      stub_current_user_for_view { create(:staff_user) }
      render
    end

    it 'does not display Deactivate link for the admin user' do
      expect(rendered).not_to have_link('a', text: 'Deactivate')
    end

    it 'does not display Run test link for the admin user' do
      expect(rendered).not_to have_link('a', text: 'Run tests')
    end

    it 'does not display Add package link for the admin user' do
      expect(rendered).not_to have_link('a', text: 'Add package')
    end

    it 'does not display Edit link for the admin user' do
      expect(rendered).not_to have_link('a', text: 'Edit')
    end

    it 'displays a link to show package files loaded' do
      assert_select 'a', text: 'Show pkg files'.to_s, href: '/package_files/completed?package_id=tv'.to_s
    end

    it 'displays a details package link' do
      assert_select 'a', text: 'Details'.to_s, href: '/packages/1'.to_s
    end
  end
end
