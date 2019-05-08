require 'rails_helper'

RSpec.describe 'digital_bookplates_batches/new/delete_batch', type: :view do
  before do
    stub_current_user_for_view { FactoryBot.create(:staff_user) }
    @digital_bookplates_batch = FactoryBot.create(:digital_bookplates_add_batches)
    assign(:digital_bookplates_batches, [@digital_bookplates_batch])
    render template: 'digital_bookplates_batches/delete_batch.html.erb'
  end

  it 'displays header for deleting a batch' do
    assert_select 'h2', text: 'Delete digital bookplate metadata from Symphony records'.to_s
  end
  it 'displays bookplate data in a table' do
    assert_select 'table>tbody>tr>td', text: 'ABBASI'.to_s, count: 1
    assert_select 'table>tbody>tr>td', text: 'rn593kb3193'.to_s, count: 1
    assert_select 'table>tbody>tr>td', text: 'Sohaib and Sara Abbasi Collection'.to_s, count: 1
  end
  it 'has a hidden field with \"delete\" as the value' do
    assert_select 'input[type=hidden][value=delete]'
  end
end
