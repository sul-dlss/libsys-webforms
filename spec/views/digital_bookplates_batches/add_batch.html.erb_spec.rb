require 'rails_helper'

RSpec.describe 'digital_bookplates_batches/new/add_batch', type: :view do
  before do
    stub_current_user_for_view { FactoryBot.create(:staff_user) }
    @digital_bookplates_batch = FactoryBot.create(:digital_bookplates_add_batches)
    assign(:digital_bookplates_batches, [@digital_bookplates_batch])
    render template: 'digital_bookplates_batches/add_batch.html.erb'
  end
  it 'should display header for adding a batch' do
    assert_select 'h2', text: 'Add digital bookplate metadata to Symphony records'.to_s
  end
  it 'should display bookplate data in a table' do
    assert_select 'table>tbody>tr>td', text: 'ABBASI'.to_s, count: 1
    assert_select 'table>tbody>tr>td', text: 'rn593kb3193'.to_s, count: 1
    assert_select 'table>tbody>tr>td', text: 'Sohaib and Sara Abbasi Collection'.to_s, count: 1
  end
  it 'should have a hidden field with \"add\" as the value' do
    assert_select 'input[type=hidden][value=add]'
  end
end
