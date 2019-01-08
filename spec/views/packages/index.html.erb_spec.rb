require 'rails_helper'

RSpec.describe 'packages/index', type: :view do
  before(:each) do
    @package = FactoryBot.create(:package)
    assign(:packages, [@package])
  end

  context 'for eloader package management admin user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:admin_user) }
      render
    end
    it 'should display deactivate package link' do
      assert_select 'a', text: 'Deactivate'.to_s, action: 'deactivate'.to_s
    end
    it 'should display a details package link' do
      assert_select 'a', text: 'Details'.to_s, href: '/packages/1'.to_s
    end
    it 'should display an edit package link' do
      assert_select 'a', text: 'Edit'.to_s, href: '/packages/1/edit'.to_s
    end
    it 'should display a link to show package files loaded' do
      assert_select 'a', text: 'Show pkg files'.to_s, href: '/package_files/completed?package_id=tv'.to_s
    end
    it 'should display a link to add a package' do
      assert_select 'a', text: 'Add package'.to_s, href: '/packages/new'.to_s
    end
    it 'should display a link to run test loads' do
      assert_select 'a', text: 'Run tests'.to_s, href: '/packages/run_tests'.to_s
    end
  end

  context 'for eloader package management staff user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:staff_user) }
      render
    end
    it 'should not display links for the admin user' do
      expect(rendered).to_not have_css('a', text: 'Deactivate')
      expect(rendered).to_not have_css('a', text: 'Run tests')
      expect(rendered).to_not have_css('a', text: 'Add package')
      expect(rendered).to_not have_css('a', text: 'Edit')
    end
    it 'should display a link to show package files loaded' do
      assert_select 'a', text: 'Show pkg files'.to_s, href: '/package_files/completed?package_id=tv'.to_s
    end
    it 'should display a details package link' do
      assert_select 'a', text: 'Details'.to_s, href: '/packages/1'.to_s
    end
  end
end
