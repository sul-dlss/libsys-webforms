require 'rails_helper'

RSpec.describe 'digital_bookplates_batches/completed', type: :view do
  before do
    stub_current_user_for_view { FactoryBot.create(:staff_user) }
    @digital_bookplates_batch = FactoryBot.create(:digital_bookplates_completed_batches)
    assign(:digital_bookplates_batches, [@digital_bookplates_batch])
    render
  end
  it 'should display the comleted date in PST timezone' do
    expect(rendered).to match('Mar-14-2018 12:02 PM')
  end
  it 'should not display a delete button to delete a batch' do
    assert_select 'table>tbody>tr>td>a', text: 'Delete'.to_s, count: 0
  end
end
