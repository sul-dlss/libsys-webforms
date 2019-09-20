require 'rails_helper'

RSpec.describe 'digital_bookplates_batches/queue', type: :view do
  before do
    stub_current_user_for_view { FactoryBot.create(:staff_user) }
    @digital_bookplates_batch = FactoryBot.create(:digital_bookplates_add_batches)
    assign(:digital_bookplates_batches, [@digital_bookplates_batch])
    render
  end

  it 'displays the submit date in PST timezone' do
    # shows two spaces because hour is one digit
    expect(rendered).to match('Mar-13-2018  8:52 PM')
  end

  it 'displays a delete button to delete a batch' do
    assert_select 'table>tbody>tr>td>a', text: 'Delete'.to_s, count: 1
  end
end
