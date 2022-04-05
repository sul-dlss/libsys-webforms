require 'rails_helper'

RSpec.describe 'accession_numbers/index', type: :view do
  before do
    stub_current_user_for_view { create(:authorized_user) }
    assign(:accession_numbers, [AccessionNumber.create!(item_type: 'Type of material',
                                                        location: 'Location',
                                                        prefix: 'Prefix',
                                                        seq_num: 2),
                                AccessionNumber.create!(item_type: 'Type of material',
                                                        location: 'Location',
                                                        prefix: 'Prefix',
                                                        seq_num: 2)])
  end

  it 'renders a list of accession_numbers' do
    render
    assert_select 'tr>td', text: 'Type of material'.to_s, count: 2
    assert_select 'tr>td', text: 'Location'.to_s, count: 2
    assert_select 'tr>td', text: 'Prefix'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end

  it 'has a link to create a new accession number type' do
    render
    assert_select 'a', text: 'New accession number type and location'.to_s, href: '/accession_numbers/new'.to_s
  end

  it 'has a link back to the accession number menu' do
    render
    assert_select 'a', text: 'Accession number menu'.to_s, href: '/accession_number_updates'.to_s
  end

  it 'has edit buttons next to each accession number in the list' do
    render
    assert_select 'tr>td>a', text: 'Edit'.to_s, count: 2
  end
end
