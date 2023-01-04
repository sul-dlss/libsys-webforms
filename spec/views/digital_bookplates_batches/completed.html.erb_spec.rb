require 'rails_helper'

RSpec.describe 'digital_bookplates_batches/completed' do
  before do
    stub_current_user_for_view { create(:staff_user) }
    @digital_bookplates_batch = create(:digital_bookplates_completed_batches)
    assign(:digital_bookplates_batches, [@digital_bookplates_batch])
    render
  end

  it 'displays the completed date in PST timezone' do
    expect(rendered).to match('Mar-14-2018 12:02 PM')
  end

  it 'does not display a delete button to delete a batch' do
    assert_select 'table>tbody>tr>td>a', text: 'Delete'.to_s, count: 0
  end
end
