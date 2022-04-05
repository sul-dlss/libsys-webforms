require 'rails_helper'

RSpec.describe 'digital_bookplates_batches/index', type: :view do
  context 'with admin user for digital bookplate batches' do
    before do
      stub_current_user_for_view { create(:admin_user) }
      render
    end

    it 'displays a list of add and delete batch links' do
      assert_select 'a', text: 'Add digital bookplate metadata to Symphony records'.to_s,
                         href: '/digital_bookplates_batches/new/add_batch'.to_s
      assert_select 'a', text: 'Delete digital bookplate metadata from Symphony records'.to_s,
                         href: '/digital_bookplates_batches/new/delete_batch'.to_s
    end

    it 'displays a link to batches in the queue' do
      assert_select 'a', text: 'Show batches in queue'.to_s, href: '/digital_bookplates_batches/queue'.to_s
    end

    it 'displays a link to completed batches' do
      assert_select 'a', text: 'Show completed batches'.to_s, href: '/digital_bookplates_batches/completed'.to_s
    end
  end

  context 'with staff user for digital bookplate batches' do
    before do
      stub_current_user_for_view { create(:staff_user) }
      render
    end

    it 'displays only the add batch link' do
      assert_select 'a', text: 'Add digital bookplate metadata to Symphony records'.to_s,
                         href: '/digital_bookplates_batches/new/add_batch'.to_s
      expect(rendered).not_to have_css('a', text: 'Delete digital bookplate metadata from Symphony records')
    end

    it 'displays a link to batches in the queue' do
      assert_select 'a', text: 'Show batches in queue'.to_s, href: '/digital_bookplates_batches/queue'.to_s
    end

    it 'displays a link to completed batches' do
      assert_select 'a', text: 'Show completed batches'.to_s, href: '/digital_bookplates_batches/completed'.to_s
    end
  end
end
