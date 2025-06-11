require 'rails_helper'

RSpec.describe 'accession_numbers/index' do
  before do
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
    assert_select 'tr>td', text: 'Type of material', count: 2
    assert_select 'tr>td', text: 'Location', count: 2
    assert_select 'tr>td', text: 'Prefix', count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end

  it 'has a link to create a new accession number type' do
    render
    assert_select 'a', text: 'New accession number', href: '/accession_numbers/new'
  end

  it 'has a link back to the accession number menu' do
    render
    assert_select 'a', text: 'Back', href: '/accession_number_updates'
  end

  it 'has edit buttons next to each accession number in the list' do
    render
    assert_select 'tr>td>a', text: 'Edit', count: 2
  end
end
