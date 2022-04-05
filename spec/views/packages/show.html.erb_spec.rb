require 'rails_helper'

RSpec.describe 'packages/show', type: :view do
  before do
    @package = create(:package)
  end

  context 'when eloader package management staff user' do
    before do
      stub_current_user_for_view { create(:staff_user) }
      render template: 'packages/show.html.erb'
    end

    it 'displays package information in a table' do
      assert_select 'table>tbody>tr>td>strong', text: 'Package ID'.to_s
      assert_select 'table>tbody>tr>td>strong', text: 'Package name'.to_s
    end

    it 'displays label for processing rules' do
      assert_select 'table>tbody>tr>td', text: 'Merge or new'.to_s, count: 1
      assert_select 'table>tbody>tr>td', text: '776 (subfield z) to Symphony 020 or 776'.to_s, count: 1
    end

    it 'displays label for MARC encoding level' do
      assert_select 'table>tbody>tr>td', text: 'Do not replace'.to_s, count: 1
    end

    it 'displays empty "Create new record or merge URL" field if there are no processing rules' do
      @package.update(proc_type: nil, match_opts: nil)
      expect(render(template: 'packages/show.html.erb')).not_to have_css('td', text: 'Merge or new')
    end

    it 'displays empty "Fields to match incoming to Symphony" field if there are no processing rules' do
      @package.update(proc_type: nil, match_opts: nil)
      expect(render(template: 'packages/show.html.erb'))
        .not_to have_css('td', text: '776 (subfield z) to Symphony 020 or 776')
    end
  end

  context 'when eloader package management admin user' do
    before do
      stub_current_user_for_view { create(:admin_user) }
      render template: 'packages/show.html.erb'
    end

    it 'displays an edit package link' do
      assert_select 'a', text: 'Edit package'.to_s, href: '/packages/1/edit'.to_s
    end

    it 'displays a delete package link' do
      assert_select 'a', text: 'Delete package'.to_s, href: '/packages/1'.to_s
    end
  end
end
