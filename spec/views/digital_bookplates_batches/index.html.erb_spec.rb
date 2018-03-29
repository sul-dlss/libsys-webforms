require 'rails_helper'

RSpec.describe 'digital_bookplates_batches/index', type: :view do
  context 'admin user for digital bookplate batches' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:admin_user) }
      render
    end
    it 'should display a list of add and delete batch links' do
      assert_select 'a', text: 'Add digital bookplate metadata to Symphony records'.to_s,
                         href: '/digital_bookplates_batches/new/add_batch'.to_s
      assert_select 'a', text: 'Delete digital bookplate metadata from Symphony records'.to_s,
                         href: '/digital_bookplates_batches/new/delete_batch'.to_s
    end
    it 'should display a link to batches in the queue' do
      assert_select 'a', text: 'Show batches in queue'.to_s, href: '/digital_bookplates_batches/queue'.to_s
    end
    it 'should display a link to completed batches' do
      assert_select 'a', text: 'Show completed batches'.to_s, href: '/digital_bookplates_batches/completed'.to_s
    end
  end

  context 'staff user for digital bookplate batches' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:staff_user) }
      render
    end
    it 'should display only the add batch link' do
      assert_select 'a', text: 'Add digital bookplate metadata to Symphony records'.to_s,
                         href: '/digital_bookplates_batches/new/add_batch'.to_s
      expect(rendered).to_not have_css('a', text: 'Delete digital bookplate metadata from Symphony records')
    end
    it 'should display a link to batches in the queue' do
      assert_select 'a', text: 'Show batches in queue'.to_s, href: '/digital_bookplates_batches/queue'.to_s
    end
    it 'should display a link to completed batches' do
      assert_select 'a', text: 'Show completed batches'.to_s, href: '/digital_bookplates_batches/completed'.to_s
    end
  end
end
